import 'package:core_components/core_components.dart';
import 'package:ips_events_manager/widgets/event_panel.dart';
import 'package:ips_events_manager/widgets/events_padding/events_padding.dart';

class EventsList extends StatelessWidget {
  const EventsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EventsPadding(
      padding: EventsEdgeInsets.symmetric(
        horizontal: EventsSize.normal,
      ),
      child: ListView.separated(
        itemBuilder: (context, index) {
          return const EventPanel();
        },
        itemCount: 4,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 20,
          );
        },
      ),
    );
  }
}
