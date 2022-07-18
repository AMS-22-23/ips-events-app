import 'package:core_components/core_components.dart';
import 'package:ips_events_manager/main_nav/cubit/navigation_cubit.dart';
import 'package:ips_events_manager/theme/colors.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({required this.sideMenuKey, Key? key}) : super(key: key);

  final GlobalKey<SideMenuState> sideMenuKey;
  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return Material(
          elevation: 10,
          child: Row(
            children: [
              SalomonBottomBar(
                currentIndex: state.tabIndex,
                onTap: _changeTab,
                items: [
                  /// Home
                  SalomonBottomBarItem(
                    icon: const Icon(Icons.home),
                    title: Text(t(LocaleKeys.events)),
                    selectedColor: Colors.purple,
                  ),

                  /// Likes
                  SalomonBottomBarItem(
                    icon: const Icon(MdiIcons.calendarAccount),
                    title: Text(t(LocaleKeys.myEvents)),
                    selectedColor: lightBlack,
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  final _state = widget.sideMenuKey.currentState;
                  if (_state!.isOpened) {
                    _state.closeSideMenu();
                  } else {
                    _state.openSideMenu();
                  }
                },
                //  BlocProvider.of<SettingsNavCubit>(context).triggerMenu(),
                icon: const Icon(Icons.menu_book),
              )
            ],
          ),
        );
      },
    );
  }

  void _changeTab(int index) {
    BlocProvider.of<NavigationCubit>(context)
        .changeTab(NavigationTab.values[index]);
  }
}
