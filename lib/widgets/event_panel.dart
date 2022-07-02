import 'package:core_components/core_components.dart';
import 'package:ips_events_manager/widgets/event_date_label.dart';
import 'package:ips_events_manager/widgets/events_padding/events_padding.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EventPanel extends StatelessWidget {
  const EventPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple,
      height: 200,
      child: EventsPadding(
        padding: EventsEdgeInsets.all(EventsSize.normal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'ent title data data'.toUpperCase(),
              style: const TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: const [
                Icon(
                  MdiIcons.arrowRight,
                  color: Colors.white,
                ),
                SizedBox(width: 10),
                Text('datadata')
              ],
            ),
            const EventDateLabel(),
          ],
        ),
      ),
    );
  }
}
