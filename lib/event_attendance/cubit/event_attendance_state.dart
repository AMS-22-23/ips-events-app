part of 'event_attendance_cubit.dart';

abstract class EventAttendanceState extends Equatable {
  const EventAttendanceState();

  @override
  List<Object> get props => [];
}

class EventAttendanceInitial extends EventAttendanceState {}

class EventAttendanceInitializing extends EventAttendanceState {}

class EventAttendanceAdvertising extends EventAttendanceState {
  const EventAttendanceAdvertising({
    required this.uuid,
  });

  final String uuid;
}

class EventAttendanceBluetoothOff extends EventAttendanceState {}

class EventAttendanceLocationOff extends EventAttendanceState {}

class EventAttendanceNoPermission extends EventAttendanceState {}

class EventAttendanceNotSupported extends EventAttendanceState {}

class EventAttendanceError extends EventAttendanceState {}
