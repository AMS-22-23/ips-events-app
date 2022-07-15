import 'package:meta_components/meta_components.dart';
import 'package:repositories/src/models/cursors.dart';

part 'paging.g.dart';

@JsonSerializable()
class Paging {
  Paging({
    required this.limit,
    this.cursors,
  });

  factory Paging.fromJson(Map<String, dynamic> json) => _$PagingFromJson(json);
  Map<String, dynamic> toJson() => _$PagingToJson(this);

  final int limit;
  final Cursors? cursors;
}
