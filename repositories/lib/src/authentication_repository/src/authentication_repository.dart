//import 'package:authentication_repository/authentication_repository.dart';
import 'dart:async';
import 'dart:developer';

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
    try {
      await addOauth.logout();

      await addOauth.login();
      final at = await addOauth.getAccessToken();
      final it = await addOauth.getIdToken();

      log('Access Token: $at');
      log('Id Token: $it');
    } on Object catch (e) {
      log(e.toString());
    }
  }
}
