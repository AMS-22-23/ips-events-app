import 'package:meta_components/meta_components.dart';
import 'package:repositories/src/models/user_role.dart';
import 'package:repositories/src/user_repository/src/models/user_avatar.dart';

part 'user_profile.g.dart';

@JsonSerializable()
class UserProfile {
  UserProfile({
    required this.id,
    required this.role,
    required this.jobTitle,
    required this.name,
    required this.email,
    this.avatar,
  });
  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileToJson(this);

  final String id;
  final UserRole role;
  final String jobTitle;
  final String name;
  final String email;
  final UserAvatar? avatar;
}
