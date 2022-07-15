// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paging.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Paging _$PagingFromJson(Map<String, dynamic> json) => Paging(
      limit: json['limit'] as int,
      cursors: json['cursors'] == null
          ? null
          : Cursors.fromJson(json['cursors'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PagingToJson(Paging instance) => <String, dynamic>{
      'limit': instance.limit,
      'cursors': instance.cursors,
    };
