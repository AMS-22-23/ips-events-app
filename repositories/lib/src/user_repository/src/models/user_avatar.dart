import 'package:meta_components/meta_components.dart';

part 'user_avatar.g.dart';

@JsonSerializable()
class UserAvatar {
  UserAvatar({required this.path, required this.mimeType});
  factory UserAvatar.fromJson(Map<String, dynamic> json) =>
      _$UserAvatarFromJson(json);

  Map<String, dynamic> toJson() => _$UserAvatarToJson(this);

  final String path;
  final String mimeType;
}
