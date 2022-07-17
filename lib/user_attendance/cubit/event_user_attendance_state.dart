part of 'event_user_attendance_cubit.dart';

abstract class EventUserAttendanceState extends Equatable {
  const EventUserAttendanceState();

  @override
  List<Object> get props => [];
}

class EventUserAttendanceInitial extends EventUserAttendanceState {}

class EventUserAttendanceLoadInProgress extends EventUserAttendanceState {}

class EventUserAttendanceLoadSuccess extends EventUserAttendanceState {}

class EventUserAttendanceLoadError extends EventUserAttendanceState {}
