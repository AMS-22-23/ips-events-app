import 'package:core_components/core_components.dart';
import 'package:ips_events_manager/main_nav/cubit/navigation_cubit.dart';
import 'package:ips_events_manager/settings_nav/cubit/settings_nav_cubit.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({Key? key}) : super(key: key);

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
                    title: const Text('Home'),
                    selectedColor: Colors.purple,
                  ),

                  /// Likes
                  SalomonBottomBarItem(
                    icon: const Icon(MdiIcons.calendarAccount),
                    title: const Text('Likes'),
                    selectedColor: Colors.pink,
                  ),

                  /// Search
                  SalomonBottomBarItem(
                    icon: const Icon(Icons.search),
                    title: const Text('Search'),
                    selectedColor: Colors.orange,
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: () =>
                    BlocProvider.of<SettingsNavCubit>(context).triggerMenu(),
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
