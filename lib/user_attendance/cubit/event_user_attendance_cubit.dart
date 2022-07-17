import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repositories/repositories.dart';

part 'event_user_attendance_state.dart';

class EventUserAttendanceCubit extends Cubit<EventUserAttendanceState> {
  EventUserAttendanceCubit({required this.eventAttendanceRepository})
      : super(EventUserAttendanceInitial());

  final EventAttendanceRepository eventAttendanceRepository;

  Future<void> addUserAttendance({required String eventId}) async {
    try {
      emit(EventUserAttendanceLoadInProgress());
      await Future<void>.delayed(const Duration(seconds: 3));
      await eventAttendanceRepository.addAttendee(eventId: eventId);
      emit(EventUserAttendanceLoadSuccess());
    } catch (e) {
      log(e.toString());
      emit(EventUserAttendanceLoadError());
    }
  }
}
