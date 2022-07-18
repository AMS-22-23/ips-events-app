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

  Future<bool> requestBluetoothConnectPermission() async {
    final isPermanentlyDenied =
        await isPermissionPermanentDenied(AppPermission.bluetoothConnect);

    if (isPermanentlyDenied) {
      await openSettings();
      return isPermissionGranted(AppPermission.bluetoothConnect);
    }
    return _requestPermission(AppPermission.bluetoothConnect);
  }

  Future<bool> requestBluetoothAdvertisePermission() async {
    final isPermanentlyDenied =
        await isPermissionPermanentDenied(AppPermission.bluetoothAdvertise);

    if (isPermanentlyDenied) {
      await openSettings();
      return isPermissionGranted(AppPermission.bluetoothAdvertise);
    }
    return _requestPermission(AppPermission.bluetoothAdvertise);
  }

  Future<bool> requestBluetoothScanPermission() async {
    final isPermanentlyDenied =
        await isPermissionPermanentDenied(AppPermission.bluetoothScan);

    if (isPermanentlyDenied) {
      await openSettings();
      return isPermissionGranted(AppPermission.bluetoothScan);
    }
    return _requestPermission(AppPermission.bluetoothScan);
  }

  Future<bool> openSettings() async => openAppSettings();
}
