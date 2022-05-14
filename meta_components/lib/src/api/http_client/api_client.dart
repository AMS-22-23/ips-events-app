import 'dart:io';

import 'package:meta_components/meta_components.dart';
import 'package:meta_components/src/api/api_constants.dart';

class PtBrandHttpCLient {
  PtBrandHttpCLient()
      : _storage = MetaCollection.instance.retrieve<FlutterSecureStorage>()
            as FlutterSecureStorage;

  final FlutterSecureStorage _storage;

  static BaseOptions _options(String baseUrl) => BaseOptions(
        connectTimeout: 8000,
        receiveTimeout: 10000,
        baseUrl: baseUrl,
      );

  InterceptorsWrapper _authTokenInterceptor() {
    return InterceptorsWrapper(
      onRequest: (request, handler) async {
        final token = await _storage.read(key: KeyConstants.USER_TOKEN);
        if (token!.isNotEmpty) {
          request.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(request);
      },
      onError: (e, handler) async {
        if (e.response?.statusCode == HttpStatus.unauthorized) {
          try {
            //config refresh
          } catch (e, st) {}
        }
      },
    );
  }

  Dio get devDio => Dio(_options(AppCredentials.development().apiBaseUrl))
    ..interceptors.add(_authTokenInterceptor());
  Dio get intDio => Dio(_options(AppCredentials.integration().apiBaseUrl))
    ..interceptors.add(_authTokenInterceptor());
}
