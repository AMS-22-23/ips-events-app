import 'package:core_components/core_components.dart';
import 'package:ips_events_manager/widgets/events_padding/events_size.dart';

class EventsEdgeInsets extends EdgeInsets {
  EventsEdgeInsets.all(EventsSize size) : super.all(size.size);

  EventsEdgeInsets.fromLTRB(
    EventsSize left,
    EventsSize top,
    EventsSize right,
    EventsSize bottom,
  ) : super.fromLTRB(
          left.size,
          top.size,
          right.size,
          bottom.size,
        );

  EventsEdgeInsets.only({
    EventsSize left = EventsSize.none,
    EventsSize top = EventsSize.none,
    EventsSize right = EventsSize.none,
    EventsSize bottom = EventsSize.none,
  }) : super.only(
          left: left.size,
          top: top.size,
          right: right.size,
          bottom: bottom.size,
        );

  EventsEdgeInsets.symmetric({
    EventsSize vertical = EventsSize.none,
    EventsSize horizontal = EventsSize.none,
  }) : super.symmetric(
          vertical: vertical.size,
          horizontal: horizontal.size,
        );
}
