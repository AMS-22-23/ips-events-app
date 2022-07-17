import 'package:meta_components/meta_components.dart';
import 'package:meta_components/src/api/auth_interceptor.dart';

class PtBrandHttpCLient {
  static BaseOptions _options(String baseUrl) => BaseOptions(
        connectTimeout: 15000,
        receiveTimeout: 20000,
        baseUrl: baseUrl,
      );

  String _getDevApiUrl() {
    final apiCredentials = AppCredentials.development();
    return '${apiCredentials.apiBaseUrl}:${apiCredentials.port}/v${apiCredentials.version}';
  }

  String _getIntApiUrl() {
    final apiCredentials = AppCredentials.integration();
    return '${apiCredentials.apiBaseUrl}/v${apiCredentials.version}';
  }

  Dio get devDio =>
      Dio(_options(_getDevApiUrl()))..interceptors.add(AuthInterceptor());
  Dio get intDio =>
      Dio(_options(_getIntApiUrl()))..interceptors.add(AuthInterceptor());
}
