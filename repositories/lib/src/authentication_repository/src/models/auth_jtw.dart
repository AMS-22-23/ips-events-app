import 'package:meta_components/meta_components.dart';

part 'auth_jtw.g.dart';

@JsonSerializable()
class AuthJtw {
  AuthJtw({required this.accessToken});
  factory AuthJtw.fromJson(Map<String, dynamic> json) =>
      _$AuthJtwFromJson(json);

  Map<String, dynamic> toJson() => _$AuthJtwToJson(this);

  @JsonKey(name: 'access_token')
  final String accessToken;
}
