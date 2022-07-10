import 'package:core_components/core_components.dart';
import 'package:ips_events_manager/widgets/event_date_label.dart';
import 'package:ips_events_manager/widgets/events_padding/events_padding.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EventPanel extends StatelessWidget {
  const EventPanel({
    required this.eventName,
    required this.date,
    required this.speakerName,
    this.onTap,
    Key? key,
  }) : super(key: key);

  final String eventName;
  final DateTime date;
  final String speakerName;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Material(
        elevation: onTap != null ? 0 : 20,
        child: Container(
          color: Colors.purple,
          height: 200,
          child: EventsPadding(
            padding: EventsEdgeInsets.all(EventsSize.normal),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  eventName.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      MdiIcons.arrowRight,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    Text('by $speakerName')
                  ],
                ),
                EventDateLabel(
                  dateString: DateFormat.MMMd().format(date),
                  timeString: DateFormat.Hm().format(date),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
