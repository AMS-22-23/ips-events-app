import 'package:meta_components/meta_components.dart';
import 'package:repositories/src/authentication_repository/src/models/auth_jtw.dart';
import 'package:repositories/src/authentication_repository/src/models/auth_response.dart';

part 'authentication_repository.g.dart';

@RestApi()
abstract class AuthenticationRepository {
  factory AuthenticationRepository(Dio dio, {String baseUrl}) =
      _AuthenticationRepository;

  @POST('/auth')
  Future<AuthJtw> login(@Body() AuthAad authAad);
}
