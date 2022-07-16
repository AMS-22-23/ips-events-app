import 'package:meta_components/meta_components.dart';
import 'package:repositories/src/events_repository/src/models/models.dart';

part 'event_details.g.dart';

@JsonSerializable()
class EventDetails {
  EventDetails({
    required this.id,
    required this.title,
    required this.description,
    required this.speaker,
    required this.isOnline,
    required this.startDate,
    required this.categoriesIds,
    required this.busySeats,
    required this.confirmedAttendances,
    required this.isOpenDoor,
    required this.isOver,
    this.eventCreator,
    this.room,
    this.meetingLink,
    this.targetCourse,
    this.targetCourseUnit,
    this.maximumCapacity,
    this.availableSeats,
    this.creationDate,
  });

  factory EventDetails.fromJson(Map<String, dynamic> json) =>
      _$EventDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$EventDetailsToJson(this);

  final String id;
  final String title;
  final String description;
  final String speaker;

  @JsonKey(name: 'created_by')
  final EventCreator? eventCreator;
  @JsonKey(name: 'categories_ids')
  final List<String> categoriesIds;
  final EventRoom? room;

  @JsonKey(name: 'meeting_link')
  final String? meetingLink;
  @JsonKey(name: 'target_course')
  final String? targetCourse;
  @JsonKey(name: 'target_course_unit')
  final String? targetCourseUnit;

  @JsonKey(name: 'maximum_capacity')
  final int? maximumCapacity;
  @JsonKey(name: 'available_seats')
  final int? availableSeats;
  @JsonKey(name: 'busy_seats')
  final int busySeats;
  @JsonKey(name: 'confirmed_attendances')
  final int confirmedAttendances;

  @JsonKey(name: 'date_time')
  final DateTime startDate;
  @JsonKey(name: 'created_at')
  final DateTime? creationDate;

  @JsonKey(name: 'is_online')
  final bool isOnline;
  @JsonKey(name: 'is_open_door')
  final bool isOpenDoor;
  @JsonKey(name: 'is_over')
  final bool isOver;
}
