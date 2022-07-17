import 'package:meta_components/meta_components.dart';
import 'package:repositories/repositories.dart';

part 'attendee_event.g.dart';

@JsonSerializable()
class AttendeeEvent {
  AttendeeEvent({
    required this.id,
    required this.event,
    this.attendanceDate,
  });

  factory AttendeeEvent.fromJson(Map<String, dynamic> json) =>
      _$AttendeeEventFromJson(json);
  Map<String, dynamic> toJson() => _$AttendeeEventToJson(this);

  final String id;
  final EventPreview event;
  @JsonKey(name: 'attendance_time')
  final DateTime? attendanceDate;
}
