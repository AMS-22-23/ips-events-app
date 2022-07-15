import 'package:meta_components/meta_components.dart';

part 'cursors.g.dart';

@JsonSerializable()
class Cursors {
  Cursors({
    this.next,
    this.previous,
  });

  factory Cursors.fromJson(Map<String, dynamic> json) =>
      _$CursorsFromJson(json);
  Map<String, dynamic> toJson() => _$CursorsToJson(this);

  final String? next;
  final String? previous;
}
