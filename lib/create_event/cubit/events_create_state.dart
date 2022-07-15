part of 'events_create_cubit.dart';

abstract class EventsCreateState extends Equatable {
  const EventsCreateState();

  @override
  List<Object> get props => [];
}

class EventsCreateInitial extends EventsCreateState {}

class EventsCreateLoadInProgress extends EventsCreateState {}

class EventsCreateLoadSuccess extends EventsCreateState {}

class EventsCreateLoadError extends EventsCreateState {}
