// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendee_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendeeEvent _$AttendeeEventFromJson(Map<String, dynamic> json) =>
    AttendeeEvent(
      id: json['id'] as String,
      event: EventPreview.fromJson(json['event'] as Map<String, dynamic>),
      attendanceDate: json['attendance_time'] == null
          ? null
          : DateTime.parse(json['attendance_time'] as String),
    );

Map<String, dynamic> _$AttendeeEventToJson(AttendeeEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'event': instance.event,
      'attendance_time': instance.attendanceDate?.toIso8601String(),
    };
