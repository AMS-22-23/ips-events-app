import 'package:core_components/core_components.dart';
import 'package:ips_events_manager/main_nav/cubit/navigation_cubit.dart';
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
        return SalomonBottomBar(
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
              icon: const Icon(Icons.favorite_border),
              title: const Text('Likes'),
              selectedColor: Colors.pink,
            ),

            /// Search
            SalomonBottomBarItem(
              icon: const Icon(Icons.search),
              title: const Text('Search'),
              selectedColor: Colors.orange,
            ),

            /// Profile
            SalomonBottomBarItem(
              icon: const Icon(Icons.person),
              title: const Text('Profile'),
              selectedColor: Colors.teal,
            ),
          ],
        );
      },
    );
  }

  void _changeTab(int index) {
    BlocProvider.of<NavigationCubit>(context)
        .changeTab(NavigationTab.values[index]);
  }
}
