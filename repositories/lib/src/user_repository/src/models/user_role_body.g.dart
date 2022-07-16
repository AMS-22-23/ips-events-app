// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_role_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRoleBody _$UserRoleBodyFromJson(Map<String, dynamic> json) => UserRoleBody(
      role: $enumDecode(_$UserRoleEnumMap, json['role']),
    );

Map<String, dynamic> _$UserRoleBodyToJson(UserRoleBody instance) =>
    <String, dynamic>{
      'role': _$UserRoleEnumMap[instance.role],
    };

const _$UserRoleEnumMap = {
  UserRole.regular: 'regular',
  UserRole.speaker: 'speaker',
  UserRole.admin: 'admin',
};
