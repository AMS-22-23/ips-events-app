import 'dart:io';

import 'package:http_parser/http_parser.dart';
import 'package:meta_components/meta_components.dart';
import 'package:repositories/src/user_repository/src/models/user.dart';
import 'package:repositories/src/user_repository/src/models/user_profile.dart';
import 'package:repositories/src/user_repository/src/models/user_role_body.dart';

part 'user_repository.g.dart';

@RestApi()
abstract class UserRepository {
  factory UserRepository(Dio dio, {String baseUrl}) = _UserRepository;

  @PUT('/user/profile/avatar')
  @MultiPart()
  Future<void> updateProfilePicture({
    @Part(contentType: 'image/jpeg') required File avatar,
  });

  @GET('/user/profile')
  Future<UserProfile> getUserProfile();

  @GET('/user')
  Future<List<User>> getUsers({
    @Query('search') String? search,
    @Query('limit') int limit = 25,
    @Query('sort_field ') String? sortingField,
    @Query('sort_ascending ') bool? sortAscending = false,
    @Query('next') String? nextPageCursor,
    @Query('previous') String? previousPageCursor,
  });

  @GET('/user/{id}')
  Future<User> getSingleUser({
    @Path('id') required String userId,
  });

  @PUT('/user/{id}/role')
  Future<void> updateUserRole({
    @Path('id') required String userId,
    @Body() required UserRoleBody userRole,
  });
}
