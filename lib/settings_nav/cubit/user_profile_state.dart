part of 'user_profile_cubit.dart';

abstract class UserProfileState extends Equatable {
  const UserProfileState();

  @override
  List<Object> get props => [];
}

class UserProfileInitial extends UserProfileState {}

class UserProfileLoadInProgress extends UserProfileState {}

class UserProfileLoadSuccess extends UserProfileState {
  const UserProfileLoadSuccess({
    required this.userProfile,
    this.avatarBytes,
  });
  final UserProfile userProfile;
  final Uint8List? avatarBytes;
}

class UserProfileLoadError extends UserProfileState {}
