// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_attendance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventAttendance _$EventAttendanceFromJson(Map<String, dynamic> json) =>
    EventAttendance(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      attendanceTime: DateTime.parse(json['attendance_time'] as String),
    );

Map<String, dynamic> _$EventAttendanceToJson(EventAttendance instance) =>
    <String, dynamic>{
      'user': instance.user,
      'attendance_time': instance.attendanceTime.toIso8601String(),
    };
