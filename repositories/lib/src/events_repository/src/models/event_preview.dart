import 'package:meta_components/meta_components.dart';

part 'event_preview.g.dart';

@JsonSerializable()
class EventPreview {
  EventPreview({
    required this.id,
    required this.title,
    required this.speaker,
    required this.isOnline,
    required this.dateTime,
  });

  factory EventPreview.fromJson(Map<String, dynamic> json) =>
      _$EventPreviewFromJson(json);
  Map<String, dynamic> toJson() => _$EventPreviewToJson(this);

  final String id;
  final String title;
  final String speaker;
  @JsonKey(name: 'is_online')
  final bool isOnline;
  @JsonKey(name: 'date_time')
  final DateTime dateTime;
}
