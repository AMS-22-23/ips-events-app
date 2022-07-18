import 'package:core_components/core_components.dart';
import 'package:ips_events_manager/widgets/event_date_label.dart';
import 'package:ips_events_manager/widgets/event_presense_label.dart';
import 'package:ips_events_manager/widgets/events_padding/events_padding.dart';

class EventPanel extends StatelessWidget {
  const EventPanel({
    required this.eventName,
    required this.date,
    required this.speakerName,
    this.onTap,
    this.isPresent,
    Key? key,
  }) : super(key: key);

  final String eventName;
  final DateTime date;
  final String speakerName;
  final VoidCallback? onTap;
  final bool? isPresent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EventsEdgeInsets.all(EventsSize.xSmall),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.purple,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(4),
              bottomLeft: Radius.circular(4),
              bottomRight: Radius.circular(4),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 3,
                offset: const Offset(5, 10), // changes position of shadow
              ),
            ],
          ),
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
                Row(
                  children: [
                    EventDateLabel(
                      dateString: DateFormat.MMMd().format(date),
                      timeString: DateFormat.Hm().format(date),
                    ),
                    const Spacer(),
                    if (isPresent != null)
                      EventPresenceLabel(
                        isPresent: isPresent!,
                      )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
