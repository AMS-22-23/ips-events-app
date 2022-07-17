import 'package:core_components/core_components.dart';
import 'package:ips_events_manager/event_details/view/ips_events_detail.dart';
import 'package:ips_events_manager/widgets/event_panel.dart';
import 'package:ips_events_manager/widgets/events_padding/events_padding.dart';

class MyEventsList extends StatelessWidget {
  const MyEventsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EventsPadding(
      padding: EventsEdgeInsets.symmetric(
        horizontal: EventsSize.normal,
      ),
      child: ListView.separated(
        itemCount: 8,
        itemBuilder: (context, index) {
          return EventPanel(
            eventName: 'eventName',
            date: DateTime(2022, index, index, index),
            speakerName: 'speakerName',
            // onTap: () => _onTap(context),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 20,
          );
        },
      ),
    );
  }

  void _onTap(BuildContext context, String eventId) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => EventDetails(
          eventId: eventId,
        ),
      ),
    );
  }
}
