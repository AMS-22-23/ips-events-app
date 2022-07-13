import 'package:core_components/core_components.dart';
import 'package:ips_events_manager/app/routes/app_routes.dart';
import 'package:ips_events_manager/ips_events/cubit/event_category_cubit.dart';
import 'package:ips_events_manager/ips_events/view/event_category_list.dart';
import 'package:ips_events_manager/ips_events/view/events_list.dart';
import 'package:ips_events_manager/widgets/icons/icons.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Events',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(
              context,
              AppRoutes.createEvent.toRoute(),
            ),
            icon: DarkIcon(
              MdiIcons.plusBox,
              size: 30,
            ),
          )
        ],
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 100,
            child: BlocProvider<EventCategoryCubit>(
              create: (context) => EventCategoryCubit(),
              child: const EventCategoryList(),
            ),
          ),
          const Expanded(child: EventsList()),
        ],
      ),
    );
  }
}
