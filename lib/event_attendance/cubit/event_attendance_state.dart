part of 'event_attendance_cubit.dart';

abstract class EventAttendanceState extends Equatable {
  const EventAttendanceState();

  @override
  List<Object> get props => [];
}

class EventAttendanceInitial extends EventAttendanceState {}

class EventAttendanceLoadInProgress extends EventAttendanceState {}

class EventAttendanceAdvertising extends EventAttendanceState {}

class EventAttendanceBluetoothOff extends EventAttendanceState {}

class EventAttendanceNoPermission extends EventAttendanceState {}

class EventAttendanceNotSupported extends EventAttendanceState {}

class EventAttendanceError extends EventAttendanceState {}
