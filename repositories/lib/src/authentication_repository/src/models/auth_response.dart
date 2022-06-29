import 'package:meta_components/meta_components.dart';

part 'auth_response.g.dart';

@JsonSerializable()
class AuthAad {
  AuthAad({required this.aadAccessToken});
  factory AuthAad.fromJson(Map<String, dynamic> json) =>
      _$AuthAadFromJson(json);

  Map<String, dynamic> toJson() => _$AuthAadToJson(this);

  @JsonKey(name: 'azure_ad_access_token')
  final String aadAccessToken;
}
