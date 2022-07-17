// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      role: $enumDecode(_$UserRoleEnumMap, json['role']),
      jobTitle: json['jobTitle'] as String,
      name: json['name'] as String,
      avatar: json['avatar'] == null
          ? null
          : UserAvatar.fromJson(json['avatar'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'role': _$UserRoleEnumMap[instance.role]!,
      'jobTitle': instance.jobTitle,
      'name': instance.name,
      'avatar': instance.avatar,
    };

const _$UserRoleEnumMap = {
  UserRole.regular: 'regular',
  UserRole.speaker: 'speaker',
  UserRole.admin: 'admin',
};
