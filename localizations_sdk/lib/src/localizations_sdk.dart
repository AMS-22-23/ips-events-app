import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';

class LocalizationsSdk {
  static EasyLocalization localizedApp({required Widget child}) =>
      EasyLocalization(
        supportedLocales: _supportedLocales,
        path: _translationsPath,
        fallbackLocale: _supportedLocales[0],
        child: child,
      );

  static const String _translationsPath = 'localizations_sdk/assets/i18n';

  static const List<Locale> _supportedLocales = [
    Locale('en'),
    Locale('pt'),
  ];

  static Future<void> initLocalization() async {
    await EasyLocalization.ensureInitialized();
  }
}

String t(String key) => key.tr();
