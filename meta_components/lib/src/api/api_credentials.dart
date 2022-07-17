// ignore_for_file: constant_identifier_names

import 'package:meta_components/src/api/api_constants.dart';

class AppCredentials {
  AppCredentials._internal({
    required this.environment,
    required this.apiBaseUrl,
    this.port,
    this.version,
  });

  factory AppCredentials.development() => AppCredentials._internal(
        apiBaseUrl: LOCAL_BASE_API_URL,
        port: LOCAL_PORT,
        version: API_VERSION,
        environment: Environment.DEVELOPMENT,
      );

  factory AppCredentials.integration() => AppCredentials._internal(
        apiBaseUrl: REMOTE_BASE_API_URL,
        version: API_VERSION,
        environment: Environment.INTEGRATION,
      );

  final Environment environment;
  final String apiBaseUrl;
  final int? port;
  final double? version;
}

enum Environment {
  INTEGRATION,
  DEVELOPMENT,
  PRODUCTION,
}
