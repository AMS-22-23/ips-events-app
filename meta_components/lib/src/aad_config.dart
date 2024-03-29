import 'package:aad_oauth/model/config.dart';
import 'package:core_components/core_components.dart';
import 'package:flutter/foundation.dart';

const _aadTenant = 'ad28c625-f2ca-4e91-b6d6-18922bc9391c';
const _aadClientId = 'fa4b8ab3-adf7-4fa8-87d4-23146e8758de';
const _aadScope = 'User.read';

final currentUri = Uri.base;

const _aadRedirectUri = kIsWeb
    ? 'http://localhost:8483'
    : 'msauth://com.ips_event_manager/V8msfwHjQl3cZ2DVCQcBj4uF60c%3D';

class AadConfig extends Config {
  AadConfig({required GlobalKey<NavigatorState> navigatorKey})
      : super(
          tenant: _aadTenant,
          clientId: _aadClientId,
          redirectUri: _aadRedirectUri,
          scope: _aadScope,
          navigatorKey: navigatorKey,
        );
}
