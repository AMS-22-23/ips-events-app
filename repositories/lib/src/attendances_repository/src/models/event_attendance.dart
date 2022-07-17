import 'package:meta_components/meta_components.dart';
import 'package:repositories/src/user_repository/src/models/user.dart';

part 'event_attendance.g.dart';

@JsonSerializable()
class EventAttendance {
  EventAttendance({
    required this.user,
    required this.attendanceTime,
  });

  factory EventAttendance.fromJson(Map<String, dynamic> json) =>
      _$EventAttendanceFromJson(json);
  Map<String, dynamic> toJson() => _$EventAttendanceToJson(this);

  final User user;
  @JsonKey(name: 'attendance_time')
  final DateTime attendanceTime;
}
