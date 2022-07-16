// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventRoom _$EventRoomFromJson(Map<String, dynamic> json) => EventRoom(
      id: json['id'] as String,
      room: json['room'] as String,
      block: json['block'] as String,
      floor: json['floor'] as int,
      number: json['number'] as int,
      subdivision: json['subdivision'] as String?,
      latitude:
          json['latitude'] == null ? null : double.parse(json['latitude']),
      longitude:
          json['longitude'] == null ? null : double.parse(json['longitude']),
    );

Map<String, dynamic> _$EventRoomToJson(EventRoom instance) => <String, dynamic>{
      'id': instance.id,
      'room': instance.room,
      'block': instance.block,
      'floor': instance.floor,
      'number': instance.number,
      'subdivision': instance.subdivision,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
