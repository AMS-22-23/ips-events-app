import 'dart:async';
import 'dart:developer';

import 'package:beacon_broadcast/beacon_broadcast.dart';
import 'package:core_components/core_components.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

part 'event_attendance_state.dart';

class EventAttendanceCubit extends Cubit<EventAttendanceState> {
  EventAttendanceCubit()
      : beaconBroadcast = BeaconBroadcast(),
        super(EventAttendanceInitial());

  late StreamSubscription<BluetoothState> _flutterBlueStateSubscription;
  late StreamSubscription<bool> _flutterBaconAdvertisingSubscription;
  final BeaconBroadcast beaconBroadcast;

  Future<void> init() async {
    try {
      emit(EventAttendanceLoadInProgress());

      _flutterBlueStateSubscription =
          FlutterBluePlus.instance.state.listen((state) async {
        if (state == BluetoothState.on) {
          await startBeacon();
        } else {
          await beaconBroadcast.stop();
          emit(EventAttendanceBluetoothOff());
        }
      });

      _flutterBaconAdvertisingSubscription =
          beaconBroadcast.getAdvertisingStateChange().listen((isAdvertising) {
        if (isAdvertising == true) {
          emit(EventAttendanceAdvertising());
        } else {
          emit(EventAttendanceError());
        }
      });
    } catch (e) {
      log(e.toString());
      emit(EventAttendanceError());
    }
  }

  Future<void> startBeacon() async {
    try {
      emit(EventAttendanceLoadInProgress());

      final transmissionSupportStatus =
          await beaconBroadcast.checkTransmissionSupported();
      switch (transmissionSupportStatus) {
        case BeaconStatus.notSupportedMinSdk:
        case BeaconStatus.notSupportedBle:
        case BeaconStatus.notSupportedCannotGetAdvertiser:
          return emit(EventAttendanceNotSupported());
        case BeaconStatus.supported:
          break;
      }

      await beaconBroadcast
          .setUUID('39ED98FF-2900-441A-802F-9C398FC199D2')
          .setMajorId(1)
          .setMinorId(100)
          .start();

      IpsEventsAnalytics.recordAnalytic(
        eventName: 'event_attendance_advertising',
      );

      emit(EventAttendanceAdvertising());
    } catch (e) {
      log(e.toString());
      emit(EventAttendanceError());
    }
  }

  @override
  Future<void> close() async {
    await _flutterBlueStateSubscription.cancel();
    await _flutterBaconAdvertisingSubscription.cancel();
    await beaconBroadcast.stop();
    return super.close();
  }
}
