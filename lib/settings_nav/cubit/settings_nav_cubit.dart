import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:core_components/core_components.dart';
import 'package:repositories/repositories.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

part 'settings_nav_state.dart';

final GlobalKey<SideMenuState> _menuStateKey = GlobalKey<SideMenuState>();

class CameraAccessCubit extends Cubit<SettingsNavState> {
  CameraAccessCubit({
    required this.permissionsRepository,
  }) : super(SettingsNavState(menuStateKey: _menuStateKey));

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
        emit(
          SettingsNavState(
            menuStateKey: state.menuStateKey,
            camera: currentCamera,
          ),
        );
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
