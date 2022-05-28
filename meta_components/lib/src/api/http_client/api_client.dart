import 'package:meta_components/meta_components.dart';
import 'package:meta_components/src/api/api_constants.dart';
import 'package:meta_components/src/api/auth_interceptor.dart';

class PtBrandHttpCLient {
  static BaseOptions _options(String baseUrl) => BaseOptions(
        connectTimeout: 8000,
        receiveTimeout: 10000,
        baseUrl: baseUrl,
      );

  Dio get devDio => Dio(_options(AppCredentials.development().apiBaseUrl))
    ..interceptors.add(AuthInterceptor());
  Dio get intDio => Dio(_options(AppCredentials.integration().apiBaseUrl))
    ..interceptors.add(AuthInterceptor());
}
