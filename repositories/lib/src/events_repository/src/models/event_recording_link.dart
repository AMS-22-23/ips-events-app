import 'package:meta_components/meta_components.dart';

part 'event_recording_link.g.dart';

@JsonSerializable()
class EventRecordingLink {
  EventRecordingLink({
    required this.link,
  });

  factory EventRecordingLink.fromJson(Map<String, dynamic> json) =>
      _$EventRecordingLinkFromJson(json);
  Map<String, dynamic> toJson() => _$EventRecordingLinkToJson(this);

  @JsonKey(name: 'recording_link')
  final String link;
}
