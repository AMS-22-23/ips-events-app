import 'package:meta_components/meta_components.dart';
import 'package:repositories/src/user_repository/src/models/user_avatar.dart';

part 'event_creator.g.dart';

@JsonSerializable()
class EventCreator {
  EventCreator({
    required this.id,
    required this.jobTitle,
    required this.name,
    this.avatar,
  });
  factory EventCreator.fromJson(Map<String, dynamic> json) =>
      _$EventCreatorFromJson(json);

  Map<String, dynamic> toJson() => _$EventCreatorToJson(this);

  final String id;
  final String jobTitle;
  final String name;
  final UserAvatar? avatar;
}
