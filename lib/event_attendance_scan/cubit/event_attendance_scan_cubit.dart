import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:beacons_plugin/beacons_plugin.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:haversine_distance/haversine_distance.dart';

part 'event_attendance_scan_state.dart';

final ipsCoordinates = Location(38.52235, -8.838676);

class EventAttendanceScanCubit extends Cubit<EventAttendanceScanState> {
  EventAttendanceScanCubit() : super(EventAttendanceScanInitial());

  Future<void> init() async {
    try {
      // if you need to monitor also major and minor use the original version and not this fork
      await BeaconsPlugin.addRegion(
        'myBeacon',
        '39ED98FF-2900-441A-802F-9C398FC199D20',
      ).then(print);

      await BeaconsPlugin.runInBackground(false);

      //IMPORTANT: Start monitoring once scanner is setup & ready (only for Android)
      if (Platform.isAndroid) {
        BeaconsPlugin.channel.setMethodCallHandler((call) async {
          if (call.method == 'scannerReady') {
            await BeaconsPlugin.startMonitoring();
          }
        });
      } else if (Platform.isIOS) {
        await BeaconsPlugin.startMonitoring();
      }

      final beaconEventsController = StreamController<String>.broadcast();
      BeaconsPlugin.listenToBeacons(beaconEventsController);

      beaconEventsController.stream.listen(
        (data) {
          if (data.isNotEmpty) {
            log('Beacons DataReceived: $data');
          }
        },
        onDone: () {},
        onError: (dynamic error) {
          log('Error: $error');
        },
      );
    } catch (e) {
      log(e.toString());
    }
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
}
