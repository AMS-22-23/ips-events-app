part of 'event_attendance_scan_cubit.dart';

abstract class EventAttendanceScanState extends Equatable {
  const EventAttendanceScanState();

  @override
  List<Object> get props => [];
}

class EventAttendanceScanInitial extends EventAttendanceScanState {}

class EventAttendanceScanInitializing extends EventAttendanceScanState {}

class EventAttendanceScanMonitoring extends EventAttendanceScanState {}

class EventAttendanceScanBluetoothOff extends EventAttendanceScanState {}

class EventAttendanceScanLocationOff extends EventAttendanceScanState {}

class EventAttendanceScanNoPermission extends EventAttendanceScanState {}

class EventAttendanceScanError extends EventAttendanceScanState {}
