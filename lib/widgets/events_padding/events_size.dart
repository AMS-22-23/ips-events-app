import 'package:ips_events_manager/widgets/events_padding/events_padding_constants.dart';

class EventsSize {
  const EventsSize(this.size);
  final double size;

  ///38px
  static const xxLarge = EventsSize(EventsPaddingConstant.xxLarge);

  ///32px
  static const xLarge = EventsSize(EventsPaddingConstant.xLarge);

  ///24px
  static const large = EventsSize(EventsPaddingConstant.large);

  ///16px
  static const normal = EventsSize(EventsPaddingConstant.normal);

  ///12px
  static const normalSmaller = EventsSize(EventsPaddingConstant.normalSmaller);

  ///8px
  static const small = EventsSize(EventsPaddingConstant.small);

  ///4px
  static const xSmall = EventsSize(EventsPaddingConstant.xSmall);

  ///1px
  static const xxSmall = EventsSize(EventsPaddingConstant.xxSmall);

  ///0px
  static const none = EventsSize(EventsPaddingConstant.none);
}
