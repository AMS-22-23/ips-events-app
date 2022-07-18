import 'dart:async';
import 'dart:developer';

import 'package:core_components/core_components.dart';
import 'package:meta_components/meta_components.dart';
import 'package:repositories/repositories.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required this.aadAuthenticationRepository,
    required this.authenticationRepository,
  }) : super(AuthInitial());

  final AadAuthenticationRepository aadAuthenticationRepository;
  final AuthenticationRepository authenticationRepository;

  Future<void> executeLogin() async {
    try {
      emit(AuthInProgress());
      await aadAuthenticationRepository.performAadLogin();
      final accessToken = await aadAuthenticationRepository.getAccessToken();
      log('Azure AD Access Token: $accessToken');

      IpsEventsAnalytics.recordAnalytic(
        eventName: 'aad_authentication_success',
      );

      final apiLogin = await authenticationRepository
          .login(AuthAad(aadAccessToken: accessToken!));
      log('Api Access Token: ${apiLogin.accessToken}');

      IpsEventsAnalytics.recordAnalytic(
        eventName: 'api_authentication_success',
      );

      MetaCollection.instance.archive(
        Entry<AuthToken>(
          builder: () => AuthToken(token: apiLogin.accessToken),
        ),
      );

      IpsEventsAnalytics.recordAnalytic(eventName: 'authentication_success');

      emit(AuthSuccess(accessToken));
    } on Object catch (e) {
      log(e.toString());

      IpsEventsAnalytics.recordAnalytic(eventName: 'authentication_error');

      emit(AuthFailure());
    }
  }

  Future<void> executeLogout() async {
    emit(AuthInProgress());
    await aadAuthenticationRepository.performAadLogout();
    await executeLogin();
  }
}
