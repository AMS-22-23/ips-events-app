import 'package:core_components/core_components.dart';
import 'package:ips_events_manager/main_nav/cubit/navigation_cubit.dart';
import 'package:ips_events_manager/settings_nav/cubit/settings_nav_cubit.dart';
import 'package:ips_events_manager/settings_nav/view/settings_nav.dart';

class IpsEvents extends StatelessWidget {
  const IpsEvents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SettingsNavCubit>(
          create: (context) => SettingsNavCubit(),
        ),
        BlocProvider<NavigationCubit>(
          create: (context) => NavigationCubit(),
        ),
      ],
      child: const SettingsNavigation(),
    );
  }
}
