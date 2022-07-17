import 'package:core_components/core_components.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ips_events_manager/event_attendance/cubit/cubit/event_attendance_cubit.dart';
import 'package:ips_events_manager/event_attendance/view/event_attendance.dart';
import 'package:ips_events_manager/event_details/cubit/event_details_cubit.dart';
import 'package:ips_events_manager/settings_nav/cubit/user_profile_cubit.dart';
import 'package:ips_events_manager/theme/colors.dart';
import 'package:ips_events_manager/widgets/widgets.dart';
import 'package:repositories/repositories.dart';

class EventDetails extends StatelessWidget {
  const EventDetails({required this.eventId, Key? key}) : super(key: key);

  final String eventId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EventDetailsCubit>(
      create: (context) => EventDetailsCubit(
        eventsRepository:
            RepositoryCollection.instance.retrieve<EventsRepository>(),
      )..getEventDetails(eventId: eventId),
      child: const _EventDetailsDelegate(),
    );
  }
}

class _EventDetailsDelegate extends StatelessWidget {
  const _EventDetailsDelegate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EventDetailsCubit, EventDetailsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is EventDetailsLoadInProgress) {
          return Center(
            child: SpinKitCubeGrid(
              color: lightBlack,
            ),
          );
        } else if (state is EventDetailsLoadSuccess) {
          final details = state.details;

          return _EventDetailsInfo(
            date: details.startDate,
            eventName: details.title,
            description: details.description,
            filledVacancies: details.busySeats,
            eventId: details.id,
            speakerName: details.speaker,
            vacancies: details.availableSeats,
          );
        }
        return const SizedBox();
      },
    );
  }
}

class _EventDetailsInfo extends StatelessWidget {
  const _EventDetailsInfo({
    required this.eventId,
    required this.eventName,
    required this.date,
    required this.speakerName,
    required this.description,
    required this.vacancies,
    required this.filledVacancies,
    Key? key,
  }) : super(key: key);

  final String eventId;
  final String eventName;
  final DateTime date;
  final String speakerName;
  final String description;
  final int? vacancies;
  final int filledVacancies;

  @override
  Widget build(BuildContext context) {
    final profileState = context.watch<UserProfileCubit>().state;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detalhes de Evento',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            MdiIcons.arrowLeft,
            color: lightBlack,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          if (profileState is UserProfileLoadSuccess &&
              (profileState.userProfile.role == UserRole.admin ||
                  profileState.userProfile.role == UserRole.speaker))
            IconButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (_) => BlocProvider<EventAttendanceCubit>.value(
                    value: EventAttendanceCubit(),
                    child: const EventAttendancePage(),
                  ),
                ),
              ),
              icon: DarkIcon(
                MdiIcons.cellphoneNfc,
                size: 30,
              ),
            )
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: constraints.maxWidth,
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: EventsPadding(
                    padding: EventsEdgeInsets.symmetric(
                      horizontal: EventsSize.normal,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        EventsPadding(
                          padding: EventsEdgeInsets.symmetric(
                            vertical: EventsSize.normal,
                          ),
                          child: EventPanel(
                            eventName: eventName,
                            date: date,
                            speakerName: speakerName,
                          ),
                        ),
                        EventsPadding(
                          padding: EventsEdgeInsets.symmetric(
                            vertical: EventsSize.normalSmaller,
                          ),
                          child: IpsEventsText.title(eventName),
                        ),
                        IpsEventsText.subTitle('By $speakerName'),
                        EventsPadding(
                          padding: EventsEdgeInsets.only(
                            top: EventsSize.large,
                          ),
                          child: IpsEventsText.title2('Descrição do Evento'),
                        ),
                        EventsPadding(
                          padding: EventsEdgeInsets.symmetric(
                            vertical: EventsSize.normalSmaller,
                          ),
                          child: IpsEventsText.greyBody(
                            lorem(paragraphs: 2, words: 40),
                          ),
                        ),
                        const Spacer(),
                        EventsPadding(
                          padding: EventsEdgeInsets.symmetric(
                            vertical: EventsSize.small,
                          ),
                          child: EventDateTimeCard(
                            onButtonTap: () => null,
                            dateTime: date,
                            vacancies: vacancies,
                            filledVacancies: filledVacancies,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
