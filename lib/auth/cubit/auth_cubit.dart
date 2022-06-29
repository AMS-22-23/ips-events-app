import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:repositories/repositories.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required this.authenticationRepository,
  }) : super(AuthInitial());

  final AuthenticationRepository authenticationRepository;

  Future<void> executeLogin() async {
    try {
      emit(AuthInProgress());
      await authenticationRepository.performLogin();
      final accessToken = await authenticationRepository.getAccessToken();
      emit(AuthSuccess(accessToken!));
    } on Object catch (e) {
      log(e.toString());
      emit(AuthFailure());
    }
  }

  Future<void> executeLogout() async {
    emit(AuthInProgress());
    await authenticationRepository.logOut();
    await executeLogin();
  }
}
