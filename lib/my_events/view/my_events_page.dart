import 'package:core_components/core_components.dart';
import 'package:ips_events_manager/my_events/cubit/my_events_cubit.dart';
import 'package:ips_events_manager/my_events/view/my_events_list.dart';
import 'package:ips_events_manager/theme/theme.dart';

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
        title: Text(
          t(LocaleKeys.myEvents),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: RefreshIndicator(
        color: darkBlack,
        onRefresh: () {
          IpsEventsAnalytics.recordAnalytic(
            eventName: 'my_events_refreshed',
          );
          return BlocProvider.of<MyEventsCubit>(context).getMyEvents();
        },
        child: Column(
          children: const [
            Expanded(child: MyEventsList()),
          ],
        ),
      ),
    );
  }
}
