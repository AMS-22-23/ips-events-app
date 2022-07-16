import 'package:meta_components/meta_components.dart';

enum UserRole {
  @JsonValue('regular')
  regular,
  @JsonValue('speaker')
  speaker,
  @JsonValue('admin')
  admin,
}
