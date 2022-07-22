import 'package:core_components/core_components.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/foundation.dart';
import 'package:ips_events_manager/admin_web_app/manage_categories/view/manage_categories_page.dart';
import 'package:ips_events_manager/admin_web_app/manage_users/view/manage_users_page.dart';
import 'package:ips_events_manager/admin_web_app/web_main_nav/cubit/web_navigation_cubit.dart';
import 'package:ips_events_manager/ips_events/cubit/event_category_cubit.dart';
import 'package:ips_events_manager/settings_nav/cubit/user_profile_cubit.dart';
import 'package:ips_events_manager/widgets/events_padding/events_padding.dart';
import 'package:meta_components/meta_components.dart';

class IpsEventsAdminPages extends StatefulWidget {
  const IpsEventsAdminPages({Key? key}) : super(key: key);

  @override
  State<IpsEventsAdminPages> createState() => _IpsEventsAdminPagesState();
}

class _IpsEventsAdminPagesState extends State<IpsEventsAdminPages> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<WebNavigationCubit, WebNavigationState>(
          listenWhen: (previous, current) =>
              current.tabIndex != previous.tabIndex,
          listener: (context, state) {
            _pageController.jumpToPage(state.tabIndex);
          },
        ),
        BlocListener<EventCategoryCubit, EventCategoryState>(
          listener: (context, state) {
            // TODO: implement listener
          },
        ),
      ],
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              SideMenu(
                // Page controller to manage a PageView
                controller: _pageController,
                // Will shows on top of all items, it can be a logo or a Title text
                title: EventsPadding(
                  padding:
                      EventsEdgeInsets.symmetric(vertical: EventsSize.normal),
                  child: Column(
                    children: [
                      EventsPadding(
                        padding: EventsEdgeInsets.symmetric(
                          vertical: EventsSize.small,
                        ),
                        child: Image.asset(_getImageUrl()),
                      ),
                      BlocBuilder<UserProfileCubit, UserProfileState>(
                        builder: (context, state) {
                          if (state is UserProfileLoadSuccess) {
                            return Column(
                              children: [
                                Text(
                                  '${t(LocaleKeys.hello)}, ${state.userProfile.name}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                const SizedBox(height: 20),
                                ListTile(
                                  horizontalTitleGap: 2,
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
                                  leading: const Icon(
                                    MdiIcons.email,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                  title: Text(state.userProfile.email),
                                  textColor: Colors.white,
                                  dense: true,
                                ),
                              ],
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ],
                  ),
                ),
                // Will show on bottom of SideMenu when displayMode was SideMenuDisplayMode.open
                footer: const Text('demo'),
                // Notify when display mode changed
                onDisplayModeChanged: print,

                style: SideMenuStyle(
                  decoration: const BoxDecoration(),
                  openSideMenuWidth: 200,
                  compactSideMenuWidth: 40,
                  hoverColor: Colors.blue[100],
                  selectedColor: Colors.lightBlue,
                  selectedIconColor: Colors.white,
                  backgroundColor: Colors.blueGrey,
                  selectedTitleTextStyle: const TextStyle(color: Colors.white),
                  unselectedTitleTextStyle:
                      const TextStyle(color: Colors.black54),
                  iconSize: 20,
                ),
                // List of SideMenuItem to show them on SideMenu
                items: [
                  SideMenuItem(
                    icon: const Icon(MdiIcons.accountMultiple),
                    title: 'Users',
                    onTap: () => _changeTab(0),
                    priority: 0,
                  ),
                  SideMenuItem(
                    icon: const Icon(MdiIcons.commentMultiple),
                    title: 'Categories',
                    onTap: () => _changeTab(1),
                    priority: 1,
                  ),
                ],
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    BlocProvider<EventCategoryCubit>.value(
                      value: BlocProvider.of<EventCategoryCubit>(context),
                      child: const ManageUsersPage(),
                    ),
                    BlocProvider<EventCategoryCubit>.value(
                      value: BlocProvider.of<EventCategoryCubit>(context),
                      child: const ManageCategoriesPage(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getImageUrl() {
    final credentials =
        MetaCollection.instance.retrieve<AppCredentials>() as AppCredentials;
    final urlStart = (kIsWeb && credentials == AppCredentials.integration())
        ? 'assets/'
        : '';
    final url = '${urlStart}ips_logo.jpg';

    return url;
  }

  void _changeTab(int index) {
    BlocProvider.of<WebNavigationCubit>(context)
        .changeTab(NavigationTab.values[index]);
  }
}
