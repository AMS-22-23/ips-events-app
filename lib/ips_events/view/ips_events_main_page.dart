import 'package:core_components/core_components.dart';
import 'package:ips_events_manager/create_event/create_event.dart';
import 'package:ips_events_manager/create_event/cubit/events_create_cubit.dart';
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
    final categoryCubit = BlocProvider.of<EventCategoryCubit>(context);
    final createCubit = BlocProvider.of<EventsCreateCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Events',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider<EventCategoryCubit>.value(
                      value: categoryCubit,
                    ),
                    BlocProvider<EventsCreateCubit>.value(
                      value: createCubit,
                    ),
                  ],
                  child: const CreateEventPage(),
                ),
              ),
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
        children: const [
          SizedBox(
            height: 100,
            child: EventCategoryList(),
          ),
          Expanded(child: EventsList()),
        ],
      ),
    );
  }
}
