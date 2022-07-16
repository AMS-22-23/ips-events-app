// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_creator.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventCreator _$EventCreatorFromJson(Map<String, dynamic> json) => EventCreator(
      id: json['id'] as String,
      jobTitle: json['jobTitle'] as String,
      name: json['name'] as String,
      avatar: json['avatar'] == null
          ? null
          : UserAvatar.fromJson(json['avatar'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EventCreatorToJson(EventCreator instance) =>
    <String, dynamic>{
      'id': instance.id,
      'jobTitle': instance.jobTitle,
      'name': instance.name,
      'avatar': instance.avatar,
    };
