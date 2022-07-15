part of 'events_list_cubit.dart';

abstract class EventsListState extends Equatable {
  const EventsListState();

  @override
  List<Object> get props => [];
}

class EventsListInitial extends EventsListState {}

class EventsListLoadInProgress extends EventsListState {}

class EventsListLoadSuccess extends EventsListState {
  const EventsListLoadSuccess({
    required this.events,
  });
  final ModelListing<EventPreview> events;
}

class EventsListLoadError extends EventsListState {}
