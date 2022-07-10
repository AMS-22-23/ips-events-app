import 'package:core_components/core_components.dart';
import 'package:ips_events_manager/theme/colors.dart';
import 'package:ips_events_manager/widgets/events_padding/events_padding.dart';

class EventDateLabel extends StatelessWidget {
  const EventDateLabel({
    required this.dateString,
    required this.timeString,
    Key? key,
  }) : super(key: key);

  final String dateString;
  final String timeString;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 35,
      color: darkBlack,
      child: EventsPadding(
        padding: EventsEdgeInsets.all(EventsSize.small),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(dateString),
            const Text(
              '| ',
              style: TextStyle(
                fontSize: 25,
                height: 1,
              ),
              textAlign: TextAlign.center,
            ),
            Text(timeString),
          ],
        ),
      ),
    );
  }
}
