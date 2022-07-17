// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventDetails _$EventDetailsFromJson(Map<String, dynamic> json) => EventDetails(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      speaker: json['speaker'] as String,
      isOnline: json['is_online'] as bool,
      startDate: DateTime.parse(json['date_time'] as String),
      categories: (json['categories'] as List<dynamic>)
          .map((e) => EventCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
      busySeats: json['busy_seats'] as int,
      confirmedAttendances: json['confirmed_attendances'] as int,
      isOpenDoor: json['is_open_door'] as bool,
      isOver: json['is_over'] as bool,
      eventCreator: json['created_by'] == null
          ? null
          : EventCreator.fromJson(json['created_by'] as Map<String, dynamic>),
      room: json['room'] as String?,
      meetingLink: json['meeting_link'] as String?,
      targetCourse: json['target_course'] as String?,
      targetCourseUnit: json['target_course_unit'] as String?,
      maximumCapacity: json['maximum_capacity'] as int?,
      availableSeats: json['available_seats'] as int?,
      creationDate: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$EventDetailsToJson(EventDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'speaker': instance.speaker,
      'created_by': instance.eventCreator,
      'categories': instance.categories,
      'room': instance.room,
      'meeting_link': instance.meetingLink,
      'target_course': instance.targetCourse,
      'target_course_unit': instance.targetCourseUnit,
      'maximum_capacity': instance.maximumCapacity,
      'available_seats': instance.availableSeats,
      'busy_seats': instance.busySeats,
      'confirmed_attendances': instance.confirmedAttendances,
      'date_time': instance.startDate.toIso8601String(),
      'created_at': instance.creationDate?.toIso8601String(),
      'is_online': instance.isOnline,
      'is_open_door': instance.isOpenDoor,
      'is_over': instance.isOver,
    };
