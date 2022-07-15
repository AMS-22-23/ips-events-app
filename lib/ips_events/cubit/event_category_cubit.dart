import 'dart:developer';

import 'package:core_components/core_components.dart';
import 'package:repositories/repositories.dart';

part 'event_category_state.dart';

class EventCategoryCubit extends Cubit<EventCategoryState> {
  EventCategoryCubit({required this.categoriesRepository})
      : super(const EventCategoryState());

  final CategoriesRepository categoriesRepository;

  Future<void> getCategories() async {
    try {
      emit(EventCategoryLoadInProgress());
      final categories = await categoriesRepository.getCategories();
      emit(EventCategoryLoadSuccess(categories: categories));
    } catch (e) {
      log(e.toString());
      emit(EventCategoryLoadError());
    }
  }

  void selectCategory(EventCategory category) {
    final currentCategory = state.categories!.firstWhere(
      (element) => element.id == category.id,
    );
    emit(state.copyWithIndex(state.categories!.indexOf(currentCategory)));
  }
}
