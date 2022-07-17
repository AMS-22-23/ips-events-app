import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:beacons_plugin/beacons_plugin.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'event_attendance_scan_state.dart';

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
}
