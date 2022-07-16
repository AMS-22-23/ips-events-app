// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      title: json['title'] as String,
      description: json['description'] as String,
      speaker: json['speaker'] as String,
      isOnline: json['is_online'] as bool,
      isOpenDoor: json['is_open_door'] as bool,
      dateTime: DateTime.parse(json['date_time'] as String),
      categoriesIds: (json['categories_ids'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      room: json['room'] as String,
      meetingLink: json['meeting_link'] as String?,
      targetCourse: json['target_course'] as String?,
      targetCourseUnit: json['target_course_unit'] as String?,
      maxVacancies: json['maximum_capacity'] as int?,
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'speaker': instance.speaker,
      'categories_ids': instance.categoriesIds,
      'is_online': instance.isOnline,
      'is_open_door': instance.isOpenDoor,
      'date_time': instance.dateTime.toIso8601String(),
      'room': instance.room,
      'meeting_link': instance.meetingLink,
      'target_course': instance.targetCourse,
      'target_course_unit': instance.targetCourseUnit,
      'maximum_capacity': instance.maxVacancies,
    };
