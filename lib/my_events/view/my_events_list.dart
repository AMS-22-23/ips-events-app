import 'package:core_components/core_components.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ips_events_manager/event_details/view/ips_events_detail.dart';
import 'package:ips_events_manager/my_events/cubit/my_events_cubit.dart';
import 'package:ips_events_manager/settings_nav/cubit/user_profile_cubit.dart';
import 'package:ips_events_manager/theme/theme.dart';
import 'package:ips_events_manager/user_attendee/cubit/event_user_attendee_cubit.dart';
import 'package:ips_events_manager/utils/show_snackbars.dart';
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
      child: BlocConsumer<MyEventsCubit, MyEventsState>(
        listener: (context, state) {
          if (state is MyEventsLoadError) {
            EventsSnackBars.showErrorSnackbar(
              context: context,
              message: t(LocaleKeys.errorMyEventList),
            );
          }
        },
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
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider<UserProfileCubit>.value(
              value: BlocProvider.of<UserProfileCubit>(context),
            ),
            BlocProvider<EventUserAttendeeCubit>.value(
              value: BlocProvider.of<EventUserAttendeeCubit>(context),
            ),
          ],
          child: EventDetailsPage(
            eventId: eventId,
          ),
        ),
      ),
    );
  }
}
