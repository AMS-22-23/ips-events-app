import 'package:aad_oauth/aad_oauth.dart';
import 'package:meta_components/meta_components.dart';

/// Repository which manages user authentication.
class AuthenticationRepository {
  AuthenticationRepository()
      : addOauth = AadOAuth(MetaCollection.instance.retrieve<AadConfig>());

  final AadOAuth addOauth;

  Future<void> logOut() async {
    await addOauth.logout();
  }

  Future<void> performLogin() async {
    await addOauth.login();
  }

  Future<String?> getAccessToken() async {
    final accessToken = await addOauth.getAccessToken();
    return accessToken;
  }
}
