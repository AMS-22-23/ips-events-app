import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repositories/repositories.dart';

part 'event_attendance_state.dart';

class EventUserAttendanceCubit extends Cubit<EventUserAttendanceState> {
  EventUserAttendanceCubit({required this.eventAttendanceRepository})
      : super(EventAttendanceInitial());

  final EventAttendanceRepository eventAttendanceRepository;

  Future<void> addUserAttendance({required String eventId}) async {
    try {
      emit(EventAttendanceLoadInProgress());
      await eventAttendanceRepository.addAttendee(eventId: eventId);
      emit(EventAttendanceLoadSuccess());
    } catch (e) {
      log(e.toString());
      emit(EventAttendanceLoadError());
    }
  }
}
