// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
      id: json['id'] as String,
      role: json['role'] as String,
      jobTitle: json['jobTitle'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      avatar: json['avatar'] == null
          ? null
          : UserAvatar.fromJson(json['avatar'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'role': instance.role,
      'jobTitle': instance.jobTitle,
      'name': instance.name,
      'email': instance.email,
      'avatar': instance.avatar,
    };
