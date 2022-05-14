import 'package:permission_handler/permission_handler.dart';

enum AppPermission { location }

extension PermissionsExtensions on AppPermission {
  Permission get permission {
    switch (this) {
      case AppPermission.location:
        return Permission.location;
    }
  }
}
