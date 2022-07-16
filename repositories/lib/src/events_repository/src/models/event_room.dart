import 'package:meta_components/meta_components.dart';

part 'event_room.g.dart';

@JsonSerializable()
class EventRoom {
  EventRoom({
    required this.id,
    required this.room,
    required this.block,
    required this.floor,
    required this.number,
    this.subdivision,
    required this.latitude,
    required this.longitude,
  });
  factory EventRoom.fromJson(Map<String, dynamic> json) =>
      _$EventRoomFromJson(json);

  Map<String, dynamic> toJson() => _$EventRoomToJson(this);

  final String id;
  final String room;
  final String block;
  final int floor;
  final int number;
  final String? subdivision;
  final double latitude;
  final double longitude;
}
