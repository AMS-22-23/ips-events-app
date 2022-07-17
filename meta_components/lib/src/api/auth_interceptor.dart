import 'dart:io';

import 'package:dio/dio.dart';
import 'package:meta_components/src/meta_collection/meta_collection.dart';
import 'package:meta_components/src/models/auth_token.dart';

class AuthInterceptor extends InterceptorsWrapper {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final AuthToken? authToken = MetaCollection.instance.retrieve<AuthToken>();
    final token = authToken?.token;

    if (token?.isNotEmpty ?? false) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == HttpStatus.unauthorized) {
      try {
        //config refresh
      } catch (e) {}
    }
    handler.reject(err);
  }
}
