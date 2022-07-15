part of 'event_category_cubit.dart';

class EventCategoryState extends Equatable {
  const EventCategoryState({this.categories, this.currentIndex = 0});
  final List<EventCategory>? categories;
  final int currentIndex;
  @override
  List<Object> get props => [currentIndex];

  EventCategoryState copyWithIndex(int index) {
    return EventCategoryState(categories: categories, currentIndex: index);
  }
}

class EventCategoryLoadInProgress extends EventCategoryState {}

class EventCategoryLoadSuccess extends EventCategoryState {
  const EventCategoryLoadSuccess({
    required List<EventCategory> categories,
  }) : super(categories: categories);
}

class EventCategoryLoadError extends EventCategoryState {}
