import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'event_attendance_state.dart';

class EventAttendanceCubit extends Cubit<EventAttendanceState> {
  EventAttendanceCubit() : super(EventAttendanceInitial());
}
