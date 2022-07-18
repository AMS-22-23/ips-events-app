import 'dart:developer';

import 'package:core_components/core_components.dart';
import 'package:repositories/repositories.dart';

part 'my_events_state.dart';

class MyEventsCubit extends Cubit<MyEventsState> {
  MyEventsCubit({required this.eventsRepository}) : super(MyEventsInitial());

  final EventsRepository eventsRepository;

  Future<void> getMyEvents({String? categoryId}) async {
    try {
      emit(MyEventsLoadInProgress());
      final eventsList = await eventsRepository.getAttendeeEvents();

      IpsEventsAnalytics.recordAnalytic(eventName: 'my_event_list_loaded');

      emit(MyEventsLoadSuccess(events: eventsList));
    } catch (e) {
      log(e.toString());

      IpsEventsAnalytics.recordAnalytic(
        eventName: 'my_event_list_loading_error',
      );

      emit(MyEventsLoadError());
    }
  }
}
