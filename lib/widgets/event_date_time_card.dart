import 'package:core_components/core_components.dart';
import 'package:ips_events_manager/theme/colors.dart';
import 'package:ips_events_manager/widgets/buttons/dark_icon_text_button.dart';
import 'package:ips_events_manager/widgets/events_padding/events_padding.dart';
import 'package:ips_events_manager/widgets/texts/texts.dart';

class EventDateTimeCard extends StatelessWidget {
  const EventDateTimeCard({
    required this.dateTime,
    required this.endDateTime,
    required this.vacancies,
    required this.filledVacancies,
    required this.onButtonTap,
    Key? key,
  }) : super(key: key);

  final DateTime dateTime;
  final DateTime endDateTime;
  final int vacancies;
  final int filledVacancies;
  final VoidCallback onButtonTap;
  @override
  Widget build(BuildContext context) {
    final monthString = DateFormat.MMMM().format(dateTime);
    final day = DateFormat.d().format(dateTime);
    final weekday = DateFormat.EEEE().format(dateTime);
    final time = DateFormat.Hm().format(dateTime);
    final endTime = DateFormat.Hm().format(dateTime);

    return Container(
      height: 80,
      color: Colors.white,
      child: EventsPadding(
        padding: EventsEdgeInsets.all(EventsSize.normalSmaller),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IpsEventsText.darkBody(monthString),
                const SizedBox(
                  height: 12,
                ),
                IpsEventsText.darkBody(day),
              ],
            ),
            VerticalDivider(
              thickness: 2,
              endIndent: 0,
              width: 5,
              color: scaffoldBackgroundColor,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IpsEventsText.darkBody(weekday),
                const SizedBox(
                  height: 12,
                ),
                IpsEventsText.subTitle('$time - $endTime'),
              ],
            ),
            VerticalDivider(
              thickness: 2,
              endIndent: 0,
              width: 5,
              color: scaffoldBackgroundColor,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IpsEventsText.darkBody('Vagas'),
                const SizedBox(
                  height: 12,
                ),
                IpsEventsText.subTitle('$filledVacancies/$vacancies'),
              ],
            ),
            DarkIconTextButton(
              onTap: onButtonTap,
              icon: MdiIcons.bookPlus,
              text: 'Inscrever',
            )
          ],
        ),
      ),
    );
  }
}
