import 'package:core_components/core_components.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ips_events_manager/event_details/view/ips_events_detail.dart';
import 'package:ips_events_manager/my_events/cubit/my_events_cubit.dart';
import 'package:ips_events_manager/theme/theme.dart';
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
      child: BlocBuilder<MyEventsCubit, MyEventsState>(
        builder: (context, state) {
          if (state is MyEventsLoadInProgress) {
            return Center(
              child: SpinKitCubeGrid(
                color: lightBlack,
              ),
            );
          } else if (state is MyEventsLoadSuccess) {
            return ListView.separated(
              itemCount: state.events.length,
              itemBuilder: (context, index) {
                final myEvent = state.events.elementAt(index);
                final event = myEvent.event;
                return EventPanel(
                  eventName: event.title,
                  date: event.dateTime,
                  speakerName: event.speaker,
                  onTap: () => _onTap(
                    context,
                    event.id,
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 20,
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  void _onTap(BuildContext context, String eventId) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => EventDetailsPage(
          eventId: eventId,
        ),
      ),
    );
  }
}
