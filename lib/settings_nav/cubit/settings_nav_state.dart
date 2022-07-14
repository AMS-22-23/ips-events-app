part of 'settings_nav_cubit.dart';

GlobalKey<SideMenuState> sideMenuKey = GlobalKey<SideMenuState>();

@immutable
class SettingsNavState extends Equatable {
  const SettingsNavState({required this.menuStateKey, this.camera});
  final GlobalKey<SideMenuState> menuStateKey;
  final CameraDescription? camera;

  @override
  List<Object?> get props => [menuStateKey];
}
