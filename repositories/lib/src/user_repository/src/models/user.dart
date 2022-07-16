import 'package:meta_components/meta_components.dart';
import 'package:repositories/src/user_repository/src/models/user_avatar.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  User({
    required this.id,
    required this.role,
    required this.jobTitle,
    required this.name,
    this.avatar,
  });
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  final String id;
  final String role;
  final String jobTitle;
  final String name;
  final UserAvatar? avatar;
}
