import 'package:core_components/core_components.dart';
import 'package:ips_events_manager/main_nav/cubit/navigation_cubit.dart';
import 'package:ips_events_manager/settings_nav/cubit/settings_nav_cubit.dart';
import 'package:ips_events_manager/settings_nav/cubit/user_profile_cubit.dart';
import 'package:ips_events_manager/settings_nav/view/settings_nav.dart';
import 'package:repositories/repositories.dart';

class IpsEvents extends StatelessWidget {
  const IpsEvents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SettingsNavCubit>(
          create: (context) => SettingsNavCubit(
            permissionsRepository:
                RepositoryCollection.instance.retrieve<PermissionsRepository>(),
          )..setUpCamera(),
        ),
        BlocProvider<UserProfileCubit>(
          create: (context) => UserProfileCubit(
            userRepository:
                RepositoryCollection.instance.retrieve<UserRepository>(),
          ),
        ),
        BlocProvider<NavigationCubit>(
          create: (context) => NavigationCubit(),
        ),
      ],
      child: const SettingsNavigation(),
    );
  }
}
