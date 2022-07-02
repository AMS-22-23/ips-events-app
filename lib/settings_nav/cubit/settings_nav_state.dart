part of 'settings_nav_cubit.dart';

GlobalKey<SideMenuState> sideMenuKey = GlobalKey<SideMenuState>();

@immutable
class SettingsNavState extends Equatable {
  const SettingsNavState({required this.menuStateKey});
  final GlobalKey<SideMenuState> menuStateKey;

  @override
  List<Object?> get props => [menuStateKey];
}
