import 'package:core_components/core_components.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

part 'settings_nav_state.dart';

final GlobalKey<SideMenuState> _menuStateKey = GlobalKey<SideMenuState>();

class SettingsNavCubit extends Cubit<SettingsNavState> {
  SettingsNavCubit() : super(SettingsNavState(menuStateKey: _menuStateKey));

  void triggerMenu() {
    final _state = state.menuStateKey.currentState;
    if (_state!.isOpened) {
      _state.closeSideMenu();
    } else {
      _state.openSideMenu();
    }
  }
}
