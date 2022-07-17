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

      final apiLogin = await authenticationRepository
          .login(AuthAad(aadAccessToken: accessToken!));
      log('Api Access Token: ${apiLogin.accessToken}');

      MetaCollection.instance.archive(
        Entry<AuthToken>(
          builder: () => AuthToken(token: apiLogin.accessToken),
        ),
      );

      IpsEventsAnalytics.recordAnalytic(eventName: 'testEvent');

      emit(AuthSuccess(accessToken));
    } on Object catch (e) {
      log(e.toString());
      emit(AuthFailure());
    }
  }

  Future<void> executeLogout() async {
    emit(AuthInProgress());
    await aadAuthenticationRepository.performAadLogout();
    await executeLogin();
  }
}
