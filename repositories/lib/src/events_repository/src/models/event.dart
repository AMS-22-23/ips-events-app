import 'package:meta_components/meta_components.dart';

part 'event.g.dart';

@JsonSerializable()
class Event {
  Event({
    required this.title,
    required this.description,
    required this.speaker,
    required this.isOnline,
    required this.isOpenDoor,
    required this.dateTime,
    required this.categoriesIds,
    this.roomId,
    this.meetingLink,
    this.targetCourse,
    this.targetCourseUnit,
  });

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
  Map<String, dynamic> toJson() => _$EventToJson(this);

  final String title;
  final String description;
  final String speaker;
  @JsonKey(name: 'categories_ids')
  final List<String> categoriesIds;
  @JsonKey(name: 'is_online')
  final bool isOnline;
  @JsonKey(name: 'is_open_door')
  final bool isOpenDoor;
  @JsonKey(name: 'date_time')
  final DateTime dateTime;
  @JsonKey(name: 'room_id')
  final String? roomId;
  @JsonKey(name: 'meeting_link')
  final String? meetingLink;
  @JsonKey(name: 'target_course')
  final String? targetCourse;
  @JsonKey(name: 'target_course_unit')
  final String? targetCourseUnit;
}
