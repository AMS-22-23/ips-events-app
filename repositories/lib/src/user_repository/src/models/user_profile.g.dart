// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
      id: json['id'] as String,
      role: $enumDecode(_$UserRoleEnumMap, json['role']),
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
      'role': _$UserRoleEnumMap[instance.role],
      'jobTitle': instance.jobTitle,
      'name': instance.name,
      'email': instance.email,
      'avatar': instance.avatar,
    };

const _$UserRoleEnumMap = {
  UserRole.regular: 'regular',
  UserRole.speaker: 'speaker',
  UserRole.admin: 'admin',
};
