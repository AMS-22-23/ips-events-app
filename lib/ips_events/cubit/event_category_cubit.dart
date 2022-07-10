import 'package:core_components/core_components.dart';
import 'package:ips_events_manager/ips_events/models/event_category.dart';

part 'event_category_state.dart';

final _categories = <EventCategory>[
  EventCategory(
    type: EventCategoryType.technology,
    categoryName: 'Tecnologia',
    icon: MdiIcons.laptop,
  ),
  EventCategory(
    type: EventCategoryType.health,
    categoryName: 'Health',
    icon: MdiIcons.medicalBag,
  )
];

class EventCategoryCubit extends Cubit<EventCategoryState> {
  EventCategoryCubit() : super(EventCategoryState(categories: _categories));

  void selectCategory(EventCategoryType type) {
    final category = state.categories!.firstWhere(
      (element) => element.type == type,
    );
    emit(state.copyWithIndex(state.categories!.indexOf(category)));
  }
}

enum EventCategoryType {
  technology,
  health,
}
