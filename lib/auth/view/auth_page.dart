import 'package:core_components/core_components.dart';
import 'package:ips_events_manager/app/routes/app_routes.dart';
import 'package:ips_events_manager/auth/cubit/auth_cubit.dart';
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
          child: BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                final GlobalKey<NavigatorState> navigatorKey = MetaCollection
                    .instance
                    .retrieve<GlobalKey<NavigatorState>>();
                navigatorKey.currentState!
                    .pushNamed(AppRoutes.mainNav.toRoute());
              }
            },
            child: Container(),
          ),
        ),
      ),
    );
  }
}
