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
