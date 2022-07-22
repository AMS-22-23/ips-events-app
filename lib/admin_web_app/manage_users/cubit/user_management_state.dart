part of 'user_management_cubit.dart';

abstract class UserManagementState extends Equatable {
  const UserManagementState();

  @override
  List<Object> get props => [];
}

class UserManagementInitial extends UserManagementState {}

class UserManagementLoadUsersInProgress extends UserManagementState {}

class UserManagementLoadUsersSuccess extends UserManagementState {
  const UserManagementLoadUsersSuccess({required this.users});
  final List<User> users;
}

class UserManagementLoadUsersError extends UserManagementState {}

class UserManagementUpdateRoleInProgress extends UserManagementState {}

class UserManagementUpdateRoleSuccess extends UserManagementState {}

class UserManagementUpdateRoleError extends UserManagementState {}
