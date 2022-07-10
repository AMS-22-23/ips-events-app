import 'package:core_components/core_components.dart';
import 'package:ips_events_manager/ips_events/cubit/event_category_cubit.dart';

class EventCategory {
  EventCategory({
    required this.categoryName,
    required this.type,
    required this.icon,
  });

  final EventCategoryType type;
  final String categoryName;
  final IconData icon;
}
