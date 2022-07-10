import 'package:core_components/core_components.dart';
import 'package:ips_events_manager/ips_events/cubit/event_category_cubit.dart';
import 'package:ips_events_manager/ips_events/view/event_category_list.dart';
import 'package:ips_events_manager/ips_events/view/events_list.dart';

class MyEventsPage extends StatefulWidget {
  const MyEventsPage({Key? key}) : super(key: key);

  @override
  State<MyEventsPage> createState() => _MyEventsPageState();
}

class _MyEventsPageState extends State<MyEventsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Events',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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
