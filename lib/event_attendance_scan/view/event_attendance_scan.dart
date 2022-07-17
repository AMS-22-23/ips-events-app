import 'package:core_components/core_components.dart';
import 'package:ips_events_manager/event_attendance_scan/view/beacons_list.dart';

class EventAttendanceScanPage extends StatefulWidget {
  const EventAttendanceScanPage({Key? key}) : super(key: key);

  @override
  State<EventAttendanceScanPage> createState() =>
      _EventAttendanceScanPageState();
}

class _EventAttendanceScanPageState extends State<EventAttendanceScanPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => false;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Registar Presença',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: const [
          Expanded(child: BeaconsList()),
        ],
      ),
    );
  }
}
