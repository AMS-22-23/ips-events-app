import 'dart:async';
import 'dart:developer';

import 'package:core_components/core_components.dart';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:haversine_distance/haversine_distance.dart';
import 'package:repositories/repositories.dart';

part 'event_user_attendee_state.dart';

final ipsCoordinates = Location(38.52235, -8.838676);

class EventUserAttendeeCubit extends Cubit<EventUserAttendeeState> {
  EventUserAttendeeCubit({
    required this.permissionsRepository,
    required this.eventAttendanceRepository,
  }) : super(EventUserAttendeeInitial());

  final PermissionsRepository permissionsRepository;
  final EventAttendanceRepository eventAttendanceRepository;

  Future<void> addUserAttendee({required String eventId}) async {
    try {
      emit(EventUserAttendeeLoadInProgress());
      await eventAttendanceRepository.addAttendee(eventId: eventId);

      IpsEventsAnalytics.recordAnalytic(
        eventName: 'event_user_attendee_recorded',
        parameters: {'event_id': eventId},
      );

      emit(EventUserAttendeeLoadSuccess());
    } catch (e) {
      log(e.toString());

      IpsEventsAnalytics.recordAnalytic(
        eventName: 'event_user_attendee_error',
        parameters: {'event_id': eventId},
      );
      emit(
        EventUserAttendeeLoadError(
          message: t(LocaleKeys.registerAttendanceNotPossible),
        ),
      );
    }
  }

  Future<void> addUserAttendance({
    required String eventId,
    required String uuid,
  }) async {
    try {
      emit(EventUserAttendeeLoadInProgress());

      await _initBeaconScanner();

      if (!await _searchBeacon(uuid: uuid)) {
        IpsEventsAnalytics.recordAnalytic(
          eventName: 'user_attendance_no_beacon_found',
          parameters: {'event_id': eventId},
        );
        return emit(
          EventUserAttendeeLoadError(
            message: t(LocaleKeys.speakerBeaconNotFound),
          ),
        );
      }

      IpsEventsAnalytics.recordAnalytic(
        eventName: 'user_attendance_beacon_was_found',
        parameters: {'event_id': eventId},
      );

      if (!await _isUserCloseToSchool()) {
        IpsEventsAnalytics.recordAnalytic(
          eventName: 'user_attendance_not_near_school',
          parameters: {'event_id': eventId},
        );
        return emit(
          EventUserAttendeeLoadError(
            message: t(LocaleKeys.notNearSchool),
          ),
        );
      }

      await eventAttendanceRepository.addAttendance(eventId: eventId);

      IpsEventsAnalytics.recordAnalytic(
        eventName: 'event_user_attendance_recorded',
      );

      emit(EventUserAttendeeAttendanceLoadSuccess());
    } catch (e) {
      log(e.toString());

      IpsEventsAnalytics.recordAnalytic(
        eventName: 'event_user_attendance_error',
      );

      emit(
        EventUserAttendeeLoadError(
          message: t(LocaleKeys.registerAttendanceNotPossible),
        ),
      );
    }
  }

  Future<void> _initBeaconScanner() async {
    try {
      final isBluetoothConnectPermissionEnabled =
          await permissionsRepository.requestBluetoothConnectPermission();
      if (!isBluetoothConnectPermissionEnabled) {
        IpsEventsAnalytics.recordAnalytic(
          eventName: 'event_user_attendance_no_bluetooth_connect_permission',
        );
        return emit(
          EventUserAttendeeLoadError(
            message: t(LocaleKeys.deviceNoFunctionalities),
          ),
        );
      }

      final isBluetoothScanPermissionEnabled =
          await permissionsRepository.requestBluetoothScanPermission();
      if (!isBluetoothScanPermissionEnabled) {
        IpsEventsAnalytics.recordAnalytic(
          eventName: 'event_user_attendance_no_bluetooth_scan_permission',
        );
        return emit(
          EventUserAttendeeLoadError(
            message: t(LocaleKeys.deviceNoFunctionalities),
          ),
        );
      }

      await flutterBeacon.initializeAndCheckScanning;

      if (!await flutterBeacon.checkLocationServicesIfEnabled) {
        IpsEventsAnalytics.recordAnalytic(
          eventName: 'event_user_attendance_no_location_permission',
        );
        return emit(
          EventUserAttendeeLoadError(
            message: t(LocaleKeys.needLocalizationPermission),
          ),
        );
      }

      final authorizationStatus = await flutterBeacon.authorizationStatus;
      if (authorizationStatus != AuthorizationStatus.allowed &&
          authorizationStatus != AuthorizationStatus.always) {
        return emit(
          EventUserAttendeeLoadError(
            message: t(LocaleKeys.deviceNoFunctionalities),
          ),
        );
      }

      if (!await flutterBeacon.checkLocationServicesIfEnabled) {
        return emit(
          const EventUserAttendeeLoadError(
            message:
                'Necessário ativar a Localização para utilizar esta funcionalidade',
          ),
        );
      }

      if (await flutterBeacon.bluetoothState != BluetoothState.stateOn) {
        IpsEventsAnalytics.recordAnalytic(
          eventName: 'event_user_attendance_bluetooth_off',
        );
        return emit(
          EventUserAttendeeLoadError(
            message: t(LocaleKeys.needLocalizationPermission),
          ),
        );
      }
    } catch (e) {
      log(e.toString());

      IpsEventsAnalytics.recordAnalytic(
        eventName: 'event_user_attendance_detection_error',
      );

      emit(
        EventUserAttendeeLoadError(
          message: t(LocaleKeys.errorOcurred),
        ),
      );
    }
  }

  Future<bool> _searchBeacon({
    required String uuid,
  }) async {
    final regions = <Region>[Region(identifier: 'com.ips_events_manager')];

    try {
      await flutterBeacon
          .ranging(regions)
          .firstWhere(
            (RangingResult result) => result.beacons.any(
              (Beacon beacon) =>
                  beacon.proximityUUID.toLowerCase() == uuid.toLowerCase() &&
                  beacon.major == 11305 &&
                  beacon.minor == 26780,
            ),
          )
          .timeout(const Duration(seconds: 60));
    } on TimeoutException {
      return false;
    }

    return true;
  }

  Future<bool> _isUserCloseToSchool() async {
    final userDistanceSchool = await _getUserLocationFromSchool();
    return userDistanceSchool <= 500;
  }

  Future<int> _getUserLocationFromSchool() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      permission = await Geolocator.requestPermission();

      // When we reach here, permissions are granted and we can
      // continue accessing the position of the device.
      final currentPosition = await Geolocator.getCurrentPosition();
      final distanceCalculator = HaversineDistance();

      final distanceUserSchool = distanceCalculator
          .haversine(
            Location(currentPosition.latitude, currentPosition.longitude),
            ipsCoordinates,
            Unit.METER,
          )
          .floor();

      return distanceUserSchool;
    }

    return Future.error('Location permissions are disabled.');
  }

  @override
  Future<void> close() async {
    await flutterBeacon.close;
    return super.close();
  }
}
