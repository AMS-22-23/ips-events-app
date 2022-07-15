// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_preview.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventPreview _$EventPreviewFromJson(Map<String, dynamic> json) => EventPreview(
      id: json['id'] as String,
      title: json['title'] as String,
      speaker: json['speaker'] as String,
      isOnline: json['is_online'] as bool,
      dateTime: DateTime.parse(json['date_time'] as String),
    );

Map<String, dynamic> _$EventPreviewToJson(EventPreview instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'speaker': instance.speaker,
      'is_online': instance.isOnline,
      'date_time': instance.dateTime.toIso8601String(),
    };
