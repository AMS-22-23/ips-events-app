import 'package:core_components/core_components.dart';
import 'package:ips_events_manager/theme/colors.dart';
import 'package:ips_events_manager/widgets/buttons/dark_icon_text_button.dart';
import 'package:ips_events_manager/widgets/events_padding/events_padding.dart';
import 'package:ips_events_manager/widgets/texts/texts.dart';

class EventDateTimeCard extends StatelessWidget {
  const EventDateTimeCard({
    required this.dateTime,
    required this.vacancies,
    required this.filledVacancies,
    required this.onButtonTap,
    Key? key,
  }) : super(key: key);

  final DateTime dateTime;
  final int? vacancies;
  final int filledVacancies;
  final VoidCallback onButtonTap;

  bool get hasVacancies => vacancies != null;

  @override
  Widget build(BuildContext context) {
    final monthString = DateFormat.MMMM().format(dateTime);
    final day = DateFormat.d().format(dateTime);
    final weekday = DateFormat.EEEE().format(dateTime);
    final time = DateFormat.Hm().format(dateTime);
    final vacanciesString =
        hasVacancies ? '$filledVacancies/$vacancies' : '$filledVacancies';

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
              children: [
                IpsEventsText.darkBody(weekday),
                const SizedBox(
                  height: 12,
                ),
                IpsEventsText.subTitle(time),
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
                IpsEventsText.darkBody(
                  hasVacancies ? 'Vagas' : 'Inscritos',
                ),
                const SizedBox(
                  height: 12,
                ),
                IpsEventsText.subTitle(vacanciesString),
              ],
            ),
            SizedBox(
              width: 80,
              child: DarkIconTextButton(
                onTap: hasVacancies ? onButtonTap : null,
                icon:
                    hasVacancies ? MdiIcons.bookPlus : MdiIcons.accountMultiple,
                text: hasVacancies ? 'Inscrever' : 'Livre',
              ),
            )
          ],
        ),
      ),
    );
  }
}
