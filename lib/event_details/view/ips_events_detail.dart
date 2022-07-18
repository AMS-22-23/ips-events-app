import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:core_components/core_components.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ips_events_manager/event_attendance/cubit/event_attendance_cubit.dart';
import 'package:ips_events_manager/event_attendance/view/event_attendance.dart';
import 'package:ips_events_manager/event_details/cubit/event_details_cubit.dart';
import 'package:ips_events_manager/settings_nav/cubit/user_profile_cubit.dart';
import 'package:ips_events_manager/theme/colors.dart';
import 'package:ips_events_manager/user_attendee/cubit/event_user_attendee_cubit.dart';
import 'package:ips_events_manager/widgets/widgets.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:repositories/repositories.dart';

class EventDetailsPage extends StatelessWidget {
  const EventDetailsPage({required this.eventId, Key? key}) : super(key: key);

  final String eventId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EventDetailsCubit>(
      create: (context) => EventDetailsCubit(
        eventsRepository:
            RepositoryCollection.instance.retrieve<EventsRepository>(),
      )..getEventDetails(eventId: eventId),
      child: const LoaderOverlay(child: _EventDetailsInfo()),
    );
  }
}

class _EventDetailsInfo extends StatelessWidget {
  const _EventDetailsInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileState = context.watch<UserProfileCubit>().state;
    final detailsState = context.watch<EventDetailsCubit>().state;
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
            detailsState is! EventDetailsLoadSuccess
                ? const SizedBox()
                : IconButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (_) => BlocProvider<EventAttendanceCubit>(
                          create: (context) => EventAttendanceCubit(
                            permissionsRepository: RepositoryCollection.instance
                                .retrieve<PermissionsRepository>(),
                            uuid: detailsState.details.uuid,
                          )..init(),
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
      body: BlocListener<EventUserAttendeeCubit, EventUserAttendeeState>(
        listener: (context, state) {
          if (state is EventUserAttendeeLoadInProgress) {
            context.loaderOverlay.show();
          } else if (state is EventUserAttendeeLoadSuccess) {
            context.loaderOverlay.hide();

            final snackBar = SnackBar(
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              content: AwesomeSnackbarContent(
                title: 'Sucesso!',
                message: 'Inscrição registada com sucesso.',
                contentType: ContentType.success,
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);

            Navigator.pop(context);
          } else if (state is EventUserAttendeeAttendanceLoadSuccess) {
            context.loaderOverlay.hide();

            final snackBar = SnackBar(
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              content: AwesomeSnackbarContent(
                title: 'Sucesso!',
                message: 'Presença marcada com sucesso.',
                contentType: ContentType.success,
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);

            Navigator.pop(context);
          } else if (state is EventUserAttendeeLoadError) {
            context.loaderOverlay.hide();

            final snackBar = SnackBar(
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              content: AwesomeSnackbarContent(
                title: 'Ocorreu um erro!',
                message: state.message,
                contentType: ContentType.failure,
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        child: BlocBuilder<EventDetailsCubit, EventDetailsState>(
          builder: (context, state) {
            if (state is EventDetailsLoadInProgress) {
              return Center(
                child: SpinKitCubeGrid(
                  color: lightBlack,
                ),
              );
            } else if (state is EventDetailsLoadSuccess) {
              final details = state.details;

              return SafeArea(
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
                                    eventName: details.title,
                                    date: details.startDate,
                                    speakerName: details.speaker,
                                  ),
                                ),
                                EventsPadding(
                                  padding: EventsEdgeInsets.symmetric(
                                    vertical: EventsSize.normalSmaller,
                                  ),
                                  child: IpsEventsText.title(details.title),
                                ),
                                IpsEventsText.subTitle('By ${details.speaker}'),
                                if (details.targetCourseUnit != null)
                                  _DetailsIconInfo(
                                    title: 'Unidade Orgânica Alvo',
                                    subtitle: details.targetCourseUnit!,
                                    icon: MdiIcons.bookInformationVariant,
                                  ),
                                if (details.targetCourse != null)
                                  _DetailsIconInfo(
                                    title: 'Curso Alvo',
                                    subtitle: details.targetCourse!,
                                    icon: MdiIcons.bookEducation,
                                  ),
                                if (details.room != null)
                                  _DetailsIconInfo(
                                    title: 'Sala Do Evento',
                                    subtitle: details.room!,
                                    icon: MdiIcons.bookAccount,
                                  ),
                                if (details.categories.isNotEmpty)
                                  _DetailsIconInfo(
                                    title: 'Categorias',
                                    subtitle: details.categories
                                        .map((category) => category.name)
                                        .toList()
                                        .reduce(
                                          (value, element) => ', ',
                                        ),
                                    icon: MdiIcons.lightbulbOn,
                                  ),
                                if (details.isOnline)
                                  _DetailsIconInfo(
                                    title: 'Evento Online',
                                    subtitle: 'Link: ${details.meetingLink}',
                                    icon: MdiIcons.microsoftTeams,
                                  )
                                else
                                  _DetailsIconInfo(
                                    title: 'Evento Presencial',
                                    subtitle: 'Sala: ${details.room}',
                                    icon: MdiIcons.bookAccount,
                                  ),
                                EventsPadding(
                                  padding: EventsEdgeInsets.only(
                                    top: EventsSize.large,
                                  ),
                                  child: IpsEventsText.title2(
                                    'Descrição do Evento',
                                  ),
                                ),
                                EventsPadding(
                                  padding: EventsEdgeInsets.symmetric(
                                    vertical: EventsSize.normalSmaller,
                                  ),
                                  child: IpsEventsText.greyBody(
                                    details.description,
                                  ),
                                ),
                                const Spacer(),
                                EventsPadding(
                                  padding: EventsEdgeInsets.symmetric(
                                    vertical: EventsSize.small,
                                  ),
                                  child: EventDateTimeCard(
                                    isAttendee: details.isAttendee,
                                    isAttendance: details.isAttendance,
                                    onButtonRegisterTap: () =>
                                        BlocProvider.of<EventUserAttendeeCubit>(
                                      context,
                                    ).addUserAttendee(
                                      eventId: details.id,
                                    ),
                                    onButtonIsPresentTap: () =>
                                        BlocProvider.of<EventUserAttendeeCubit>(
                                      context,
                                    ).addUserAttendance(
                                      eventId: details.id,
                                      uuid: details.uuid,
                                    ),
                                    dateTime: details.startDate,
                                    vacancies: details.maximumCapacity,
                                    filledVacancies: details.busySeats,
                                    remainingVacancies: details.availableSeats,
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
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class _DetailsIconInfo extends StatelessWidget {
  const _DetailsIconInfo({
    required this.title,
    required this.subtitle,
    required this.icon,
    Key? key,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return EventsPadding(
      padding: EventsEdgeInsets.only(
        top: EventsSize.large,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EventsPadding(
            padding: EventsEdgeInsets.only(
              bottom: EventsSize.xxSmall,
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: darkBlack,
                ),
                const SizedBox(
                  width: 5,
                ),
                IpsEventsText.title2(
                  title,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          IpsEventsText.subTitle(subtitle),
        ],
      ),
    );
  }
}
