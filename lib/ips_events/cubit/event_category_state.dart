part of 'event_category_cubit.dart';

class EventCategoryState extends Equatable {
  const EventCategoryState({required this.categories, this.currentIndex = -1});
  final List<EventCategory> categories;
  final int currentIndex;

  EventCategory? get currentCategory =>
      currentIndex < 0 ? null : categories.elementAt(currentIndex);

  EventCategoryState copyWithIndex(int index) {
    return EventCategoryState(categories: categories, currentIndex: index);
  }

  @override
  List<Object> get props => [categories, currentIndex];
}

class EventCategoryLoadInProgress extends EventCategoryState {
  const EventCategoryLoadInProgress({required super.categories});
}

class EventCategoryLoadSuccess extends EventCategoryState {
  const EventCategoryLoadSuccess({
    required List<EventCategory> categories,
  }) : super(categories: categories);
}

class EventCategoryLoadError extends EventCategoryState {
  const EventCategoryLoadError({required super.categories});
}
