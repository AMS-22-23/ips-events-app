import 'package:meta_components/meta_components.dart';

part 'event_category.g.dart';

@JsonSerializable()
class EventCategory {
  EventCategory({
    required this.id,
    required this.name,
  });

  factory EventCategory.fromJson(Map<String, dynamic> json) =>
      _$EventCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$EventCategoryToJson(this);

  final String id;
  final String name;
}
