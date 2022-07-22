import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repositories/repositories.dart';

part 'user_management_state.dart';

class UserManagementCubit extends Cubit<UserManagementState> {
  UserManagementCubit({required this.userRepository})
      : super(UserManagementInitial());

  final UserRepository userRepository;
  Future<void> getUsers() async {
    try {
      emit(UserManagementLoadUsersInProgress());
      final users = await userRepository.getUsers(limit: 100);
      emit(UserManagementLoadUsersSuccess(users: users));
    } catch (e) {
      log(e.toString());
      emit(UserManagementLoadUsersError());
    }
  }

  Future<void> updateUserRole({
    required String userId,
    required UserRole role,
  }) async {
    try {
      emit(UserManagementUpdateRoleInProgress());
      await userRepository.updateUserRole(
        userId: userId,
        userRole: UserRoleBody(role: role),
      );
      emit(UserManagementUpdateRoleSuccess());
      unawaited(getUsers());
    } catch (e) {
      log(e.toString());
      emit(UserManagementUpdateRoleError());
    }
  }
}
