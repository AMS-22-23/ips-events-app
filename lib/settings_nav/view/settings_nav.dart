import 'package:core_components/core_components.dart';
import 'package:ips_events_manager/ips_events/view/ips_events_pages.dart';
import 'package:ips_events_manager/main_nav/cubit/navigation_cubit.dart';
import 'package:ips_events_manager/main_nav/view/main_navigation.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

class SettingsNavigation extends StatelessWidget {
  const SettingsNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _sideMenuKey = GlobalKey<SideMenuState>();
    final cubit = BlocProvider.of<NavigationCubit>(context);
    return SideMenu(
      key: _sideMenuKey,
      menu: const _SettingsNavMenu(),
      type: SideMenuType.slideNRotate, // check above images
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              final _state = _sideMenuKey.currentState;
              if (_state!.isOpened) {
                _state.closeSideMenu();
              } else {
                _state.openSideMenu();
              } // open side menu
            },
          ),
        ),
        body: const IpsEventsPages(),
        bottomNavigationBar: const MainNavigation(),
      ),
    );
  }
}

class _SettingsNavMenu extends StatelessWidget {
  const _SettingsNavMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 22,
                ),
                SizedBox(height: 16),
                Text(
                  'Hello, John Doe',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.home, size: 20, color: Colors.white),
            title: const Text('Home'),
            textColor: Colors.white,
            dense: true,
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(
              Icons.verified_user,
              size: 20,
              color: Colors.white,
            ),
            title: const Text('Profile'),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(
              Icons.monetization_on,
              size: 20,
              color: Colors.white,
            ),
            title: const Text('Wallet'),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}
