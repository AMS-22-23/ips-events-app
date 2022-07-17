import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repositories/repositories.dart';

part 'event_details_state.dart';

class EventDetailsCubit extends Cubit<EventDetailsState> {
  EventDetailsCubit({required this.eventsRepository})
      : super(EventDetailsInitial());

  final EventsRepository eventsRepository;

  Future<void> getEventDetails({required String eventId}) async {
    try {
      emit(EventDetailsLoadInProgress());
      final details = await eventsRepository.getSingleEvent(eventId: eventId);
      emit(EventDetailsLoadSuccess(details: details));
    } catch (e) {
      emit(EventDetailsLoadError());
    }
  }
}
