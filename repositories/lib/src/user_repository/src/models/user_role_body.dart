import 'package:meta_components/meta_components.dart';
import 'package:repositories/src/models/user_role.dart';

part 'user_role_body.g.dart';

@JsonSerializable()
class UserRoleBody {
  UserRoleBody({
    required this.role,
  });
  factory UserRoleBody.fromJson(Map<String, dynamic> json) =>
      _$UserRoleBodyFromJson(json);

  Map<String, dynamic> toJson() => _$UserRoleBodyToJson(this);

  final UserRole role;
}
