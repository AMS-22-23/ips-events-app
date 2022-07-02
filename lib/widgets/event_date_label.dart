import 'package:core_components/core_components.dart';
import 'package:ips_events_manager/theme/colors.dart';
import 'package:ips_events_manager/widgets/events_padding/events_padding.dart';

class EventDateLabel extends StatelessWidget {
  const EventDateLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 35,
      color: darkGrey,
      child: EventsPadding(
        padding: EventsEdgeInsets.all(EventsSize.small),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('data'),
            Text(
              '| ',
              style: TextStyle(
                fontSize: 25,
                height: 1,
              ),
              textAlign: TextAlign.center,
            ),
            Text('data AM'),
          ],
        ),
      ),
    );
  }
}
