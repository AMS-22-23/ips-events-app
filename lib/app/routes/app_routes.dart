enum AppRoutes { auth, mainNav }

extension ToRoute on AppRoutes {
  String toRoute() {
    switch (this) {
      case AppRoutes.auth:
        return '/auth';
      case AppRoutes.mainNav:
        return '/main';
    }
  }
}
