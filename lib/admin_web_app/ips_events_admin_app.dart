import 'package:core_components/core_components.dart';
import 'package:ips_events_manager/admin_web_app/manage_users/cubit/user_management_cubit.dart';
import 'package:ips_events_manager/admin_web_app/web_main_nav/cubit/web_navigation_cubit.dart';
import 'package:ips_events_manager/admin_web_app/web_main_nav/view/web_ips_events_pages.dart';
import 'package:ips_events_manager/ips_events/cubit/event_category_cubit.dart';
import 'package:ips_events_manager/ips_events/cubit/events_list_cubit.dart';
import 'package:ips_events_manager/settings_nav/cubit/user_profile_cubit.dart';
import 'package:repositories/repositories.dart';

class EventsAdminApp extends StatefulWidget {
  const EventsAdminApp({Key? key}) : super(key: key);

  @override
  State<EventsAdminApp> createState() => _EventsAdminAppState();
}

class _EventsAdminAppState extends State<EventsAdminApp>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserProfileCubit>(
          create: (context) => UserProfileCubit(
            userRepository:
                RepositoryCollection.instance.retrieve<UserRepository>(),
          )..loadUserProfile(),
        ),
        BlocProvider<WebNavigationCubit>(
          create: (context) => WebNavigationCubit(),
        ),
        BlocProvider<EventsListCubit>(
          create: (context) => EventsListCubit(
            eventsRepository:
                RepositoryCollection.instance.retrieve<EventsRepository>(),
          )..getEvents(),
        ),
        BlocProvider<EventCategoryCubit>(
          create: (context) => EventCategoryCubit(
            categoriesRepository:
                RepositoryCollection.instance.retrieve<CategoriesRepository>(),
            eventsListCubit: BlocProvider.of<EventsListCubit>(context),
          )..getCategories(),
        ),
        BlocProvider<UserManagementCubit>(
          create: (context) => UserManagementCubit(
            userRepository:
                RepositoryCollection.instance.retrieve<UserRepository>(),
          )..getUsers(),
        )
      ],
      child: const IpsEventsAdminPages(),
    );
  }
}
