import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:core_components/core_components.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:meta_components/meta_components.dart';
import 'package:repositories/repositories.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  UserProfileCubit({
    required this.userRepository,
  }) : super(UserProfileInitial());

  final UserRepository userRepository;

  Future<void> saveUserPicture(String imagePath) async {
    try {
      await userRepository.updateProfilePicture(avatar: File(imagePath));
      unawaited(loadUserProfile());
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> loadUserProfile() async {
    emit(UserProfileLoadInProgress());
    try {
      final userProfile = await userRepository.getUserProfile();

      final apiCredentials =
          MetaCollection.instance.retrieve<AppCredentials>() as AppCredentials;

      String rawFilePath;
      Uint8List? imageBytes;
      late String filePath;

      if (userProfile.avatar != null) {
        if (kDebugMode) {
          final AppCredentials apiCredentials =
              MetaCollection.instance.retrieve<AppCredentials>();
          if (apiCredentials == AppCredentials.development()) {
            rawFilePath =
                '${apiCredentials.apiBaseUrl}:${apiCredentials.port}${Uri.file(userProfile.avatar!.path).toFilePath()}';
          } else {
            rawFilePath =
                '${apiCredentials.apiBaseUrl}${Uri.file(userProfile.avatar!.path).toFilePath()}';
          }
        } else {
          rawFilePath =
              '${apiCredentials.apiBaseUrl}/${Uri.file(userProfile.avatar!.path).toFilePath()}';
        }

        filePath = rawFilePath.replaceAll(r'\', '/');

        imageBytes = await getImagesBytes(filePath);
      }

      final profile = UserProfile(
        email: userProfile.email,
        id: userProfile.id,
        jobTitle: userProfile.jobTitle,
        name: userProfile.name,
        role: userProfile.role,
        avatar: userProfile.avatar == null
            ? null
            : UserAvatar(
                mimeType: userProfile.avatar!.mimeType,
                path: filePath,
              ),
      );
      emit(
        UserProfileLoadSuccess(
          userProfile: profile,
          avatarBytes: imageBytes,
        ),
      );
    } catch (e) {
      log(e.toString());
      emit(UserProfileLoadError());
    }
  }

  Future<Uint8List> getImagesBytes(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    return response.bodyBytes;
  }
}
