import 'package:core_components/core_components.dart';
import 'package:ips_events_manager/main_nav/view/ips_events_pages.dart';
import 'package:ips_events_manager/main_nav/view/main_navigation.dart';
import 'package:ips_events_manager/settings_nav/cubit/settings_nav_cubit.dart';
import 'package:ips_events_manager/settings_nav/cubit/user_profile_cubit.dart';
import 'package:ips_events_manager/settings_nav/view/profile_picture_taker.dart';
import 'package:ips_events_manager/theme/colors.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

class SettingsNavigation extends StatelessWidget {
  SettingsNavigation({Key? key}) : super(key: key);

  GlobalKey<SideMenuState> menuStateKey = GlobalKey<SideMenuState>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CameraAccessCubit, SettingsNavState>(
      builder: (context, state) {
        return SideMenu(
          key: menuStateKey,
          background: lightBlack,
          menu: const _SettingsNavMenu(),
          type: SideMenuType.slideNRotate, // check above images
          child: Scaffold(
            body: const IpsEventsPages(),
            bottomNavigationBar: MainNavigation(sideMenuKey: menuStateKey),
          ),
        );
      },
    );
  }
}

class _SettingsNavMenu extends StatelessWidget {
  const _SettingsNavMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: BlocBuilder<UserProfileCubit, UserProfileState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 40,
                          backgroundImage: state is UserProfileLoadSuccess &&
                                  state.userProfile.avatar != null
                              ? Image.memory(state.avatarBytes!).image
                              : null,
                          child: state is UserProfileLoadInProgress
                              ? const CircularProgressIndicator()
                              : null,
                        ),
                        IconButton(
                          onPressed: () => Navigator.push<void>(
                            context,
                            TakePictureScreen.route(context),
                          ),
                          icon: const Icon(
                            MdiIcons.cameraControl,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (state is UserProfileLoadSuccess)
                      Text(
                        'Hello, ${state.userProfile.name}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              if (state is UserProfileLoadSuccess)
                Column(
                  children: [
                    ListTile(
                      horizontalTitleGap: 2,
                      onTap: () {},
                      leading: const Icon(
                        MdiIcons.targetAccount,
                        size: 20,
                        color: Colors.white,
                      ),
                      title: Text(state.userProfile.jobTitle),
                      textColor: Colors.white,
                      dense: true,
                    ),
                    ListTile(
                      horizontalTitleGap: 2,

                      onTap: () {},
                      leading: const Icon(
                        MdiIcons.accountKey,
                        size: 20,
                        color: Colors.white,
                      ),
                      title: Text(
                        state.userProfile.role.name,
                      ),
                      textColor: Colors.white,
                      dense: true,
                      // padding: EdgeInsets.zero,
                    ),
                    ListTile(
                      horizontalTitleGap: 2,

                      onTap: () {},
                      leading: const Icon(
                        MdiIcons.email,
                        size: 20,
                        color: Colors.white,
                      ),
                      title: Text(state.userProfile.email),
                      textColor: Colors.white,
                      dense: true,

                      // padding: EdgeInsets.zero,
                    ),
                  ],
                ),
            ],
          );
        },
      ),
    );
  }
}
