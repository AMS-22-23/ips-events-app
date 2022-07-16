import 'package:meta_components/meta_components.dart';
import 'package:repositories/src/models/paging.dart';

part 'model_listing.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ModelListing<T> {
  ModelListing({
    required this.items,
    this.paging,
  });

  factory ModelListing.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$ModelListingFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$ModelListingToJson(this, toJsonT);

  @JsonKey(name: 'data')
  final List<T> items;
  final Paging? paging;
}
