import 'dart:async';
import 'dart:developer';

import 'package:core_components/core_components.dart';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:repositories/repositories.dart';

part 'event_attendance_state.dart';

class EventAttendanceCubit extends Cubit<EventAttendanceState> {
  EventAttendanceCubit({
    required this.permissionsRepository,
    required this.uuid,
  }) : super(EventAttendanceInitial());

  final PermissionsRepository permissionsRepository;
  final String uuid;

  late StreamSubscription<BluetoothState> _flutterBluetoothStateSubscription;

  Future<void> init() async {
    try {
      emit(EventAttendanceInitializing());

      // Check if Bluetooth is disabled and if so request required permissions to enable it
      if (await flutterBeacon.bluetoothState == BluetoothState.stateOff) {
        final isBluetoothConnectPermissionEnabled =
            await permissionsRepository.requestBluetoothConnectPermission();
        if (!isBluetoothConnectPermissionEnabled) {
          return emit(
            EventAttendanceNoPermission(),
          );
        }
      }

      final isBluetoothAdvertisePermissionEnabled =
          await permissionsRepository.requestBluetoothAdvertisePermission();
      if (!isBluetoothAdvertisePermissionEnabled) {
        return emit(
          EventAttendanceNoPermission(),
        );
      }

      if (!await flutterBeacon.isBroadcastSupported()) {
        return emit(EventAttendanceNotSupported());
      }

      _flutterBluetoothStateSubscription =
          flutterBeacon.bluetoothStateChanged().listen((state) async {
        if (state == BluetoothState.stateOn) {
          await startBroadcast();
        } else {
          await flutterBeacon.stopBroadcast();
          emit(EventAttendanceBluetoothOff());
        }
      });
    } catch (e) {
      log(e.toString());
      emit(EventAttendanceError());
    }
  }

  Future<void> startBroadcast() async {
    try {
      emit(EventAttendanceInitializing());

      await flutterBeacon.startBroadcast(
        BeaconBroadcast(
          identifier: 'com.ips_events_manager',
          proximityUUID: uuid,
          major: 0,
          minor: 0,
        ),
      );

      IpsEventsAnalytics.recordAnalytic(
        eventName: 'event_beacon_advertising',
      );

      emit(EventAttendanceAdvertising(uuid: uuid));
    } catch (e) {
      log(e.toString());
      emit(EventAttendanceError());
    }
  }

  @override
  Future<void> close() async {
    await _flutterBluetoothStateSubscription.cancel();
    await flutterBeacon.stopBroadcast();
    return super.close();
  }
}
