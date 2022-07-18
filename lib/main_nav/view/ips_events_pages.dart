import 'package:core_components/core_components.dart';
import 'package:ips_events_manager/create_event/cubit/events_create_cubit.dart';
import 'package:ips_events_manager/ips_events/view/ips_events_main_page.dart';
import 'package:ips_events_manager/main_nav/cubit/navigation_cubit.dart';
import 'package:ips_events_manager/my_events/view/my_events_page.dart';
import 'package:repositories/repositories.dart';

class IpsEventsPages extends StatefulWidget {
  const IpsEventsPages({Key? key}) : super(key: key);

  @override
  State<IpsEventsPages> createState() => _IpsEventsPagesState();
}

class _IpsEventsPagesState extends State<IpsEventsPages> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NavigationCubit, NavigationState>(
      listenWhen: (previous, current) => current.tabIndex != previous.tabIndex,
      listener: (context, state) {
        _pageController.jumpToPage(state.tabIndex);
      },
      child: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          BlocProvider<EventsCreateCubit>(
            create: (context) => EventsCreateCubit(
              eventsRepository:
                  RepositoryCollection.instance.retrieve<EventsRepository>(),
            ),
            child: const EventsPage(),
          ),
          const MyEventsPage(),
        ],
      ),
    );
  }
}
