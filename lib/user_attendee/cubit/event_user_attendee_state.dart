part of 'event_user_attendee_cubit.dart';

abstract class EventUserAttendeeState extends Equatable {
  const EventUserAttendeeState();

  @override
  List<Object> get props => [];
}

class EventUserAttendeeInitial extends EventUserAttendeeState {}

class EventUserAttendeeLoadInProgress extends EventUserAttendeeState {}

class EventUserAttendeeLoadSuccess extends EventUserAttendeeState {}

class EventUserAttendeeAttendanceLoadSuccess extends EventUserAttendeeState {}

class EventUserAttendeeLoadError extends EventUserAttendeeState {
  const EventUserAttendeeLoadError({
    required this.message,
  });
  final String message;
}
