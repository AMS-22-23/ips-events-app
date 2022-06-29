// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthAad _$AuthAadFromJson(Map<String, dynamic> json) => AuthAad(
      aadAccessToken: json['azure_ad_access_token'] as String,
    );

Map<String, dynamic> _$AuthAadToJson(AuthAad instance) => <String, dynamic>{
      'azure_ad_access_token': instance.aadAccessToken,
    };
