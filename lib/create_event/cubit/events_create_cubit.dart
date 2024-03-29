import 'dart:developer';

import 'package:core_components/core_components.dart';
import 'package:repositories/repositories.dart';

part 'events_create_state.dart';

class EventsCreateCubit extends Cubit<EventsCreateState> {
  EventsCreateCubit({required this.eventsRepository})
      : super(EventsCreateInitial());

  final EventsRepository eventsRepository;

  Future<void> createEvent({
    required String title,
    required String speaker,
    required DateTime startDate,
    required String description,
    required List<String> categoryIds,
    required String targetCourse,
    required String targetUnit,
    String? room,
    String? meetingLink,
    int? maxVacancies,
    bool isOnline = false,
    bool isOpenDoor = false,
  }) async {
    try {
      emit(EventsCreateLoadInProgress());
      await eventsRepository.createEvent(
        event: Event(
          room: room != null && room.isNotEmpty ? room : null,
          categoriesIds: categoryIds,
          dateTime: startDate.toUtc(),
          description: description,
          isOnline: isOnline,
          isOpenDoor: isOpenDoor,
          speaker: speaker,
          title: title,
          targetCourse: targetCourse,
          targetCourseUnit: targetUnit,
          maxVacancies: maxVacancies,
          meetingLink: meetingLink != null && meetingLink.isNotEmpty
              ? meetingLink
              : null,
        ),
      );
      IpsEventsAnalytics.recordAnalytic(eventName: 'event_load_detail_success');
      emit(EventsCreateLoadSuccess());
    } catch (e) {
      log(e.toString());

      IpsEventsAnalytics.recordAnalytic(eventName: 'event_load_detail_error');

      emit(EventsCreateLoadError());
    }
  }
}
