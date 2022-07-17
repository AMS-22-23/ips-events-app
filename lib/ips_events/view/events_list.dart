import 'package:core_components/core_components.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ips_events_manager/event_details/view/ips_events_detail.dart';
import 'package:ips_events_manager/ips_events/cubit/events_list_cubit.dart';
import 'package:ips_events_manager/settings_nav/cubit/user_profile_cubit.dart';
import 'package:ips_events_manager/theme/colors.dart';
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
      child: BlocConsumer<EventsListCubit, EventsListState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is EventsListLoadInProgress) {
            return Center(
              child: SpinKitCubeGrid(
                color: lightBlack,
              ),
            );
          } else if (state is EventsListLoadSuccess) {
            return ListView.separated(
              itemCount: state.events.length,
              itemBuilder: (context, index) {
                final event = state.events.elementAt(index);
                return EventPanel(
                  eventName: event.title,
                  date: event.dateTime,
                  speakerName: event.speaker,
                  onTap: () => _onTap(
                    context,
                    eventId: event.id,
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

  void _onTap(
    BuildContext context, {
    required String eventId,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => BlocProvider<UserProfileCubit>.value(
          value: BlocProvider.of<UserProfileCubit>(context),
          child: EventDetails(
            eventId: eventId,
          ),
        ),
      ),
    );
  }
}
