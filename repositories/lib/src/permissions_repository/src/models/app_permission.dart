import 'package:permission_handler/permission_handler.dart';

enum AppPermission {
  location,
  camera,
  bluetoothConnect,
  bluetoothAdvertise,
  bluetoothScan
}

extension PermissionsExtensions on AppPermission {
  Permission get permission {
    switch (this) {
      case AppPermission.location:
        return Permission.location;
      case AppPermission.camera:
        return Permission.camera;
      case AppPermission.bluetoothConnect:
        return Permission.bluetoothConnect;
      case AppPermission.bluetoothAdvertise:
        return Permission.bluetoothAdvertise;
      case AppPermission.bluetoothScan:
        return Permission.bluetoothScan;
    }
  }
}
