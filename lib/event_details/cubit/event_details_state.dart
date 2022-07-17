part of 'event_details_cubit.dart';

abstract class EventDetailsState extends Equatable {
  const EventDetailsState();

  @override
  List<Object> get props => [];
}

class EventDetailsInitial extends EventDetailsState {}

class EventDetailsLoadInProgress extends EventDetailsState {}

class EventDetailsLoadSuccess extends EventDetailsState {
  const EventDetailsLoadSuccess({
    required this.details,
  });
  final EventDetails details;
}

class EventDetailsLoadError extends EventDetailsState {}
