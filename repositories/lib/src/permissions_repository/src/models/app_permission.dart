import 'package:permission_handler/permission_handler.dart';

enum AppPermission { location, camera }

extension PermissionsExtensions on AppPermission {
  Permission get permission {
    switch (this) {
      case AppPermission.location:
        return Permission.location;
      case AppPermission.camera:
        return Permission.camera;
    }
  }
}
