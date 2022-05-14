// ignore_for_file: constant_identifier_names

import 'package:meta_components/src/api/api_credentials.dart';

class AppCredentials {
  AppCredentials._internal({
    required this.environment,
    required this.apiBaseUrl,
  });

  factory AppCredentials.development() => AppCredentials._internal(
        apiBaseUrl: LOCAL_BASE_API_URL,
        environment: Environment.DEVELOPMENT,
      );

  factory AppCredentials.integration() => AppCredentials._internal(
        apiBaseUrl: REMOTE_BASE_API_URL,
        environment: Environment.INTEGRATION,
      );

  final Environment environment;
  final String apiBaseUrl;
}

enum Environment {
  INTEGRATION,
  DEVELOPMENT,
  PRODUCTION,
}
