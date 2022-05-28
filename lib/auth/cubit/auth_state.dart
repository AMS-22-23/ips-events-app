part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthInProgress extends AuthState {}

class AuthSuccess extends AuthState {
  AuthSuccess(this.token);
  final String token;
}

class AuthFailure extends AuthState {}
