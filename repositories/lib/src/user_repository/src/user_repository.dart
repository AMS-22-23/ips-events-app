import 'dart:io';

import 'package:http_parser/http_parser.dart';
import 'package:meta_components/meta_components.dart';
import 'package:repositories/src/user_repository/src/models/user_profile.dart';

part 'user_repository.g.dart';

@RestApi()
abstract class UserRepository {
  factory UserRepository(Dio dio, {String baseUrl}) = _UserRepository;

  @PUT('/user/avatar')
  @MultiPart()
  Future<void> updateProfilePicture({
    @Part(contentType: 'image/jpeg') required File avatar,
  });

  @GET('/user')
  Future<UserProfile> getUserProfile();
}
