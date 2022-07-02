import 'package:flutter/widgets.dart';
import 'package:ips_events_manager/widgets/events_padding/events_edge_insets.dart';

class EventsPadding extends StatelessWidget {
  const EventsPadding({
    Key? key,
    required this.child,
    required this.padding,
  }) : super(key: key);
  final Widget child;
  final EventsEdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: child,
    );
  }
}
