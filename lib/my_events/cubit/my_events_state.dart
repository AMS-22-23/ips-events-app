part of 'my_events_cubit.dart';

abstract class MyEventsState extends Equatable {
  const MyEventsState();

  @override
  List<Object> get props => [];
}

class MyEventsInitial extends MyEventsState {}

class MyEventsLoadInProgress extends MyEventsState {}

class MyEventsLoadSuccess extends MyEventsState {
  const MyEventsLoadSuccess({
    required this.events,
  });
  final List<AttendeeEvent> events;
}

class MyEventsLoadError extends MyEventsState {}
