import 'dart:async';
import 'dart:developer';

import 'package:core_components/core_components.dart';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:haversine_distance/haversine_distance.dart';
import 'package:repositories/repositories.dart';

part 'event_attendance_scan_state.dart';

final ipsCoordinates = Location(38.52235, -8.838676);

class EventAttendanceScanCubit extends Cubit<EventAttendanceScanState> {
  EventAttendanceScanCubit({
    required this.permissionsRepository,
  }) : super(EventAttendanceScanInitial());

  final PermissionsRepository permissionsRepository;

  late StreamSubscription<BluetoothState> _flutterBluetoothStateSubscription;
  late StreamSubscription<RangingResult> _flutterRangingSubscription;

  Future<void> init() async {
    try {
      emit(EventAttendanceScanInitializing());

      final isBluetoothConnectPermissionEnabled =
          await permissionsRepository.requestBluetoothConnectPermission();
      if (!isBluetoothConnectPermissionEnabled) {
        return emit(
          EventAttendanceScanNoPermission(),
        );
      }

      final isBluetoothScanPermissionEnabled =
          await permissionsRepository.requestBluetoothScanPermission();
      if (!isBluetoothScanPermissionEnabled) {
        return emit(
          EventAttendanceScanNoPermission(),
        );
      }

      await flutterBeacon.initializeAndCheckScanning;

      if (!await flutterBeacon.checkLocationServicesIfEnabled) {
        return emit(EventAttendanceScanLocationOff());
      }

      final authorizationStatus = await flutterBeacon.authorizationStatus;
      if (authorizationStatus != AuthorizationStatus.allowed &&
          authorizationStatus != AuthorizationStatus.always) {
        return emit(EventAttendanceScanNoPermission());
      }

      _flutterBluetoothStateSubscription =
          flutterBeacon.bluetoothStateChanged().listen((state) async {
        if (state == BluetoothState.stateOn) {
          await startScan();
        } else {
          await _flutterRangingSubscription.cancel();
          emit(EventAttendanceScanBluetoothOff());
        }
      });
    } catch (e) {
      log(e.toString());
      emit(EventAttendanceScanError());
    }
  }

  Future<void> startScan() async {
    emit(EventAttendanceScanInitializing());

    final regions = <Region>[Region(identifier: 'com.ips_events_manager')];

    // await flutterBeacon.setScanPeriod(3000);
    // await flutterBeacon.setBetweenScanPeriod(15000);

    _flutterRangingSubscription =
        flutterBeacon.ranging(regions).listen((RangingResult result) {
      print('');
      print(result.beacons);
    });

    IpsEventsAnalytics.recordAnalytic(
      eventName: 'event_beacon_scanning',
    );

    emit(EventAttendanceScanMonitoring());
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
    await _flutterBluetoothStateSubscription.cancel();
    await _flutterRangingSubscription.cancel();
    return super.close();
  }
}
