import 'package:core_components/core_components.dart';
import 'package:ips_events_manager/theme/colors.dart';
import 'package:ips_events_manager/widgets/events_padding/events_padding.dart';

class EventPresenceLabel extends StatelessWidget {
  const EventPresenceLabel({
    required this.isPresent,
    Key? key,
  }) : super(key: key);

  final bool isPresent;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 35,
      color: darkBlack,
      child: EventsPadding(
        padding: EventsEdgeInsets.all(EventsSize.small),
        child: Center(
          child: Text(
            t(isPresent ? LocaleKeys.wasPresent : LocaleKeys.noPresence),
          ),
        ),
      ),
    );
  }
}
