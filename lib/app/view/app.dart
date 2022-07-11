// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:core_components/core_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ips_events_manager/admin_web_app/ips_events_admin_app.dart';
import 'package:ips_events_manager/app/routes/app_routes.dart';
import 'package:ips_events_manager/auth/view/auth_page.dart';
import 'package:ips_events_manager/ips_events/view/ips_events.dart';
import 'package:ips_events_manager/l10n/l10n.dart';
import 'package:ips_events_manager/theme/colors.dart';
import 'package:meta_components/meta_components.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: darkBlack,
        ),
        appBarTheme: AppBarTheme(
          color: Colors.transparent,
          titleTextStyle: TextStyle(
            color: darkBlack,
            fontSize: 20,
          ),
        ),
        textTheme: TextTheme(
          headline1: TextStyle(color: darkBlack),
          headline2: TextStyle(color: darkBlack),
          headline3: TextStyle(color: darkBlack),
          bodyText1: TextStyle(color: grey),
          bodyText2: const TextStyle(color: Colors.white),
        ),
        scaffoldBackgroundColor: scaffoldBackgroundColor,
      ),
      navigatorKey:
          MetaCollection.instance.retrieve<GlobalKey<NavigatorState>>(),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      initialRoute: defaultTargetPlatform == TargetPlatform.android ||
              defaultTargetPlatform == TargetPlatform.iOS
          ? AppRoutes.auth.toRoute()
          : AppRoutes.webApp.toRoute(),
      routes: {
        AppRoutes.auth.toRoute(): (context) => const AuthPage(),
        AppRoutes.mainNav.toRoute(): (context) => const IpsEvents(),
        AppRoutes.webApp.toRoute(): (context) => const EventsAdminApp(),
      },
    );
  }
}
