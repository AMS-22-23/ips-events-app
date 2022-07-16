import 'package:meta_components/meta_components.dart';

part 'user_role.g.dart';

@JsonSerializable()
class UserRole {
  UserRole({
    required this.role,
  });
  factory UserRole.fromJson(Map<String, dynamic> json) =>
      _$UserRoleFromJson(json);

  Map<String, dynamic> toJson() => _$UserRoleToJson(this);

  final String role;
}
