part of 'settings_nav_cubit.dart';

GlobalKey<SideMenuState> sideMenuKey = GlobalKey<SideMenuState>();

@immutable
class SettingsNavState extends Equatable {
  const SettingsNavState({this.camera});
  final CameraDescription? camera;

  @override
  List<Object?> get props => [camera];
}
