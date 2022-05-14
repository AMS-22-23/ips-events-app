//import 'package:authentication_repository/authentication_repository.dart';
import 'dart:async';
import 'dart:developer';
import 'package:core_components/core_components.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:repositories/src/authentication_repository/models/user.dart';
import 'package:repositories/src/authentication_repository/src/cache.dart';

/// {@template sign_up_with_email_and_password_failure}
/// Thrown if during the sign up process if a failure occurs.
/// {@endtemplate}
class SignUpWithEmailAndPasswordFailure implements Exception {
  /// {@macro sign_up_with_email_and_password_failure}
  const SignUpWithEmailAndPasswordFailure(this.message);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  /// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/createUserWithEmailAndPassword.html
  factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return SignUpWithEmailAndPasswordFailure(
          t(LocaleKeys.authErrors_invalidEmail),
        );
      case 'user-disabled':
        return SignUpWithEmailAndPasswordFailure(
          t(LocaleKeys.authErrors_userDisabled),
        );
      case 'email-already-in-use':
        return SignUpWithEmailAndPasswordFailure(
          t(LocaleKeys.authErrors_emailInUse),
        );
      case 'operation-not-allowed':
        return SignUpWithEmailAndPasswordFailure(
          t(LocaleKeys.authErrors_operationNotAllowed),
        );
      case 'weak-password':
        return SignUpWithEmailAndPasswordFailure(
          t(LocaleKeys.authErrors_weakPassword),
        );
      default:
        return SignUpWithEmailAndPasswordFailure(
          t(LocaleKeys.authErrors_defaultError),
        );
    }
  }

  /// The associated error message.
  final String message;
}

/// {@template log_in_with_email_and_password_failure}
/// Thrown during the login process if a failure occurs.
/// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInWithEmailAndPassword.html
/// {@endtemplate}
class LogInWithEmailAndPasswordFailure implements Exception {
  /// {@macro log_in_with_email_and_password_failure}
  const LogInWithEmailAndPasswordFailure(this.message);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory LogInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return LogInWithEmailAndPasswordFailure(
          t(LocaleKeys.authErrors_invalidEmail),
        );
      case 'user-disabled':
        return LogInWithEmailAndPasswordFailure(
          t(LocaleKeys.authErrors_userDisabled),
        );
      case 'user-not-found':
        return LogInWithEmailAndPasswordFailure(
          t(LocaleKeys.authErrors_userNotFound),
        );
      case 'wrong-password':
        return LogInWithEmailAndPasswordFailure(
          t(LocaleKeys.authErrors_wrongPassword),
        );
      default:
        return LogInWithEmailAndPasswordFailure(
          t(LocaleKeys.authErrors_defaultError),
        );
    }
  }

  /// The associated error message.
  final String message;
}

/// Thrown during the logout process if a failure occurs.
class LogOutFailure implements Exception {}

/// {@template authentication_repository}
/// Repository which manages user authentication.
/// {@endtemplate}
class AuthenticationRepository {
  /// {@macro authentication_repository}
  AuthenticationRepository({
    CacheClient? cache,
    firebase_auth.FirebaseAuth? firebaseAuth,
  })  : _cache = cache ?? CacheClient(),
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  final CacheClient _cache;
  final firebase_auth.FirebaseAuth _firebaseAuth;

  /// Whether or not the current environment is web
  /// Should only be overriden for testing purposes. Otherwise,
  /// defaults to [kIsWeb]
  @visibleForTesting
  bool isWeb = kIsWeb;

  /// User cache key.
  /// Should only be used for testing purposes.
  @visibleForTesting
  static const userCacheKey = '__user_cache_key__';

  /// Stream of [User] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [User.empty] if the user is not authenticated.
  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      _printToken(firebaseUser);
      _cache.write(key: userCacheKey, value: user);
      return user;
    });
  }

  Future<void> _printToken(firebase_auth.User? firebaseUser) async {
    final userToken = await firebaseUser?.getIdToken();
  }

  /// Returns the current cached user.
  /// Defaults to [User.empty] if there is no cached user.
  User get currentUser {
    return _cache.read<User>(key: userCacheKey) ?? User.empty;
  }

  /// Creates a new user with the provided [email] and [password].
  ///
  /// Throws a [SignUpWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;

      await user?.updateDisplayName(username);
      await user?.reload();
    } on FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw SignUpWithEmailAndPasswordFailure(
        t(LocaleKeys.authErrors_defaultError),
      );
    }
  }

  /// Signs in with the provided [email] and [password].
  ///
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw LogInWithEmailAndPasswordFailure(
        t(LocaleKeys.authErrors_defaultError),
      );
    }
  }

  /// Signs out the current user which will emit
  /// [User.empty] from the [user] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (_) {
      throw LogOutFailure();
    }
  }
}

extension on firebase_auth.User {
  User get toUser {
    return User(id: uid, email: email, name: displayName, photo: photoURL);
  }
}
