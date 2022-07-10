import 'package:core_components/core_components.dart';
import 'package:ips_events_manager/ips_events/view/ips_events_detail.dart';
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
          return EventPanel(
            eventName: 'eventName',
            date: DateTime(2022, 8, 12),
            speakerName: 'speakerName',
            onTap: () => _onTap(context),
          );
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

  void _onTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => EventDetails(
          eventName: 'eventName',
          date: DateTime(2022, 8, 12),
          speakerName: 'speakerName',
          filledVacancies: 2,
          vacancies: 10,
          description: 'some very specific description of this event',
        ),
      ),
    );
  }
}
