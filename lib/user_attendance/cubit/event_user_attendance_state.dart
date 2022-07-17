part of 'event_user_attendance_cubit.dart';

abstract class EventUserAttendanceState extends Equatable {
  const EventUserAttendanceState();

  @override
  List<Object> get props => [];
}

class EventAttendanceInitial extends EventUserAttendanceState {}

class EventAttendanceLoadInProgress extends EventUserAttendanceState {}

class EventAttendanceLoadSuccess extends EventUserAttendanceState {}

class EventAttendanceLoadError extends EventUserAttendanceState {}
