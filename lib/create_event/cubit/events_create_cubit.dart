import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
    required String room,
    required String targetCourse,
    required String targetUnit,
    int? maxVacancies,
    bool isOnline = false,
    bool isOpenDoor = false,
  }) async {
    try {
      emit(EventsCreateLoadInProgress());
      await eventsRepository.createEvent(
        event: Event(
          room: room,
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
        ),
      );
      emit(EventsCreateLoadSuccess());
    } catch (e) {
      log(e.toString());
      emit(EventsCreateLoadError());
    }
  }
}
