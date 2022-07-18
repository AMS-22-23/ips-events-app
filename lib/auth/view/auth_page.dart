import 'package:core_components/core_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ips_events_manager/app/routes/app_routes.dart';
import 'package:ips_events_manager/auth/cubit/auth_cubit.dart';
import 'package:ips_events_manager/theme/theme.dart';
import 'package:ips_events_manager/utils/show_snackbars.dart';
import 'package:meta_components/meta_components.dart';
import 'package:repositories/repositories.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) => AuthCubit(
        aadAuthenticationRepository: RepositoryCollection.instance
            .retrieve<AadAuthenticationRepository>(),
        authenticationRepository:
            RepositoryCollection.instance.retrieve<AuthenticationRepository>(),
      )..executeLogin(),
      child: const _AuthPage(),
    );
  }
}

class _AuthPage extends StatelessWidget {
  const _AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                final GlobalKey<NavigatorState> navigatorKey = MetaCollection
                    .instance
                    .retrieve<GlobalKey<NavigatorState>>();

                final routeToPush =
                    defaultTargetPlatform == TargetPlatform.android ||
                            defaultTargetPlatform == TargetPlatform.iOS
                        ? AppRoutes.mainNav.toRoute()
                        : AppRoutes.webApp.toRoute();

                IpsEventsAnalytics.recordAnalytic(
                  eventName: 'app_main_screen_opening',
                );

                navigatorKey.currentState!.popAndPushNamed(routeToPush);
              } else if (state is AuthFailure) {
                EventsSnackBars.showErrorSnackbar(
                  context: context,
                  message: t(LocaleKeys.errorOcurred),
                );
              }
            },
            builder: (context, state) {
              if (state is AuthInProgress) {
                return Scaffold(
                  body: Center(
                    child: SpinKitCubeGrid(
                      color: lightBlack,
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
