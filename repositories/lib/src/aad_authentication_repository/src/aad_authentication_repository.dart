import 'package:aad_oauth/aad_oauth.dart';
import 'package:meta_components/meta_components.dart';

/// Repository which manages user authentication.
class AadAuthenticationRepository {
  AadAuthenticationRepository()
      : addOauth = AadOAuth(MetaCollection.instance.retrieve<AadConfig>());

  final AadOAuth addOauth;

  Future<void> performAadLogout() async {
    await addOauth.logout();
  }

  Future<void> performAadLogin() async {
    await addOauth.login();
  }

  Future<String?> getAccessToken() async {
    final accessToken = await addOauth.getAccessToken();
    return accessToken;
  }
}
