import 'dart:developer';

import 'package:core_components/core_components.dart';
import 'package:ips_events_manager/ips_events/cubit/events_list_cubit.dart';
import 'package:repositories/repositories.dart';

part 'event_category_state.dart';

class EventCategoryCubit extends Cubit<EventCategoryState> {
  EventCategoryCubit({
    required this.categoriesRepository,
    required this.eventsListCubit,
  }) : super(const EventCategoryState(categories: []));

  final CategoriesRepository categoriesRepository;
  final EventsListCubit eventsListCubit;

  Future<void> getCategories() async {
    try {
      emit(EventCategoryLoadInProgress(categories: state.categories));
      final categories = await categoriesRepository.getCategories();
      IpsEventsAnalytics.recordAnalytic(eventName: 'categories_load_success');
      emit(EventCategoryLoadSuccess(categories: categories));
    } catch (e) {
      log(e.toString());

      IpsEventsAnalytics.recordAnalytic(eventName: 'categories_load_error');

      emit(EventCategoryLoadError(categories: state.categories));
    }
  }

  void selectCategory(EventCategory category) {
    try {
      if (category == state.currentCategory) {
        emit(state.copyWithIndex(-1));
        eventsListCubit.getEvents();
        return;
      }
      final currentCategory = state.categories.firstWhere(
        (element) => element.id == category.id,
      );

      final categoryIndex = state.categories.indexOf(currentCategory);

      emit(state.copyWithIndex(categoryIndex));

      IpsEventsAnalytics.recordAnalytic(
        eventName: 'categories_filtered',
        parameters: {'page_index': categoryIndex},
      );

      eventsListCubit.getEvents(categoryId: state.currentCategory!.id);
    } catch (e) {
      log(e.toString());
    }
  }
}
