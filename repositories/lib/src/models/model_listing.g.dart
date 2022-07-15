// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_listing.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelListing<T> _$ModelListingFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ModelListing<T>(
      items: (json['data'] as List<dynamic>).map(fromJsonT).toList(),
      paging: Paging.fromJson(json['paging'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ModelListingToJson<T>(
  ModelListing<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'data': instance.items.map(toJsonT).toList(),
      'paging': instance.paging,
    };
