import 'package:core_components/core_components.dart';
import 'package:ips_events_manager/ips_events/cubit/event_category_cubit.dart';
import 'package:ips_events_manager/ips_events/cubit/events_list_cubit.dart';
import 'package:ips_events_manager/main_nav/cubit/navigation_cubit.dart';
import 'package:ips_events_manager/my_events/cubit/my_events_cubit.dart';
import 'package:ips_events_manager/settings_nav/cubit/settings_nav_cubit.dart';
import 'package:ips_events_manager/settings_nav/cubit/user_profile_cubit.dart';
import 'package:ips_events_manager/settings_nav/view/settings_nav.dart';
import 'package:ips_events_manager/user_attendee/cubit/event_user_attendee_cubit.dart';
import 'package:repositories/repositories.dart';

class IpsEvents extends StatelessWidget {
  const IpsEvents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CameraAccessCubit>(
          create: (context) => CameraAccessCubit(
            permissionsRepository:
                RepositoryCollection.instance.retrieve<PermissionsRepository>(),
          )..setUpCamera(),
        ),
        BlocProvider<UserProfileCubit>(
          create: (context) => UserProfileCubit(
            userRepository:
                RepositoryCollection.instance.retrieve<UserRepository>(),
          )..loadUserProfile(),
        ),
        BlocProvider<NavigationCubit>(
          create: (context) => NavigationCubit(),
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
        BlocProvider<EventUserAttendeeCubit>(
          create: (context) => EventUserAttendeeCubit(
            permissionsRepository:
                RepositoryCollection.instance.retrieve<PermissionsRepository>(),
            eventAttendanceRepository: RepositoryCollection.instance
                .retrieve<EventAttendanceRepository>(),
          ),
        ),
        BlocProvider<MyEventsCubit>(
          create: (context) => MyEventsCubit(
            eventsRepository:
                RepositoryCollection.instance.retrieve<EventsRepository>(),
          )..getMyEvents(),
        )
      ],
      child: SettingsNavigation(),
    );
  }
}
