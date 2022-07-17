import 'package:core_components/core_components.dart';
import 'package:ips_events_manager/event_attendance_scan/cubit/event_attendance_scan_cubit.dart';
import 'package:ips_events_manager/widgets/widgets.dart';

class BeaconsList extends StatelessWidget {
  const BeaconsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EventsPadding(
      padding: EventsEdgeInsets.symmetric(
        horizontal: EventsSize.normal,
      ),
      child: BlocConsumer<EventAttendanceScanCubit, EventAttendanceScanState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return const SizedBox();
        },
      ),
    );
  }
}
