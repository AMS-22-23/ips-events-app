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
      log('hellloo');
      emit(AuthInProgress());
      await authenticationRepository.performLogin();
      emit(AuthSuccess());
    } on Object {
      emit(AuthFailure());
    }
  }
}
