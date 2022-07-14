import 'package:permission_handler/permission_handler.dart';
import 'package:repositories/src/permissions_repository/src/models/app_permission.dart';

class PermissionsRepository {
  List<AppPermission> permissions = [
    AppPermission.location,
  ];

  Future<bool> requestAllPermissions() async {
    return (await permissions.map((ap) => ap.permission).toList().request())
        .values
        .every((element) => element.isGranted);
  }

  Future<bool> _requestPermission(AppPermission appPermission) async {
    return appPermission.permission.request().isGranted;
  }

  Future<bool> isPermissionGranted(AppPermission appPermission) async {
    return appPermission.permission.isGranted;
  }

  Future<bool> existsPermissionsDenied() async {
    for (final permission in permissions.map((ap) => ap.permission)) {
      if (await permission.isDenied || await permission.isPermanentlyDenied) {
        return true;
      }
    }
    return false;
  }

  Future<bool> isPermissionPermanentDenied(AppPermission appPermission) async {
    return appPermission.permission.isPermanentlyDenied;
  }

  Future<bool> requestLocationPermission() async {
    return _requestPermission(AppPermission.location);
  }

  Future<bool> requestCameraPermission() async {
    final isPermanentlyDenied =
        await isPermissionPermanentDenied(AppPermission.camera);

    if (isPermanentlyDenied) {
      await openSettings();
      return isPermissionGranted(AppPermission.camera);
    }
    return _requestPermission(AppPermission.camera);
  }

  Future<bool> openSettings() async => openAppSettings();
}
