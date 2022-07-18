import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:core_components/core_components.dart';
import 'package:repositories/repositories.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

part 'settings_nav_state.dart';

class CameraAccessCubit extends Cubit<SettingsNavState> {
  CameraAccessCubit({
    required this.permissionsRepository,
  }) : super(const SettingsNavState());

  final PermissionsRepository permissionsRepository;

  Future<void> setUpCamera() async {
    try {
      final isCameraPermissionEnabled =
          await permissionsRepository.requestCameraPermission();

      if (isCameraPermissionEnabled) {
        final cameras = await availableCameras();

        final currentCamera = cameras.firstWhere(
          (camera) => camera.lensDirection.name == 'front',
        );

        IpsEventsAnalytics.recordAnalytic(
          eventName: 'camera_on',
        );
        return emit(
          SettingsNavState(
            camera: currentCamera,
          ),
        );
      }

      IpsEventsAnalytics.recordAnalytic(
        eventName: 'camera_off',
      );
    } catch (e) {
      log(e.toString());

      IpsEventsAnalytics.recordAnalytic(
        eventName: 'camera_no_access',
      );
    }
  }
}
