import 'dart:developer';

import 'package:core_components/core_components.dart';
import 'package:repositories/repositories.dart';

part 'events_list_state.dart';

class EventsListCubit extends Cubit<EventsListState> {
  EventsListCubit({required this.eventsRepository})
      : super(EventsListInitial());

  final EventsRepository eventsRepository;

  Future<void> getEvents({String? categoryId}) async {
    try {
      emit(EventsListLoadInProgress());
      final eventsList =
          await eventsRepository.getEvents(categoryId: categoryId);

      IpsEventsAnalytics.recordAnalytic(eventName: 'event_list_loaded');

      emit(EventsListLoadSuccess(events: eventsList));
    } catch (e) {
      log(e.toString());
      emit(EventsListLoadError());
    }
  }
}
