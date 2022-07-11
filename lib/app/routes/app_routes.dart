enum AppRoutes { auth, mainNav, webApp }

extension ToRoute on AppRoutes {
  String toRoute() {
    switch (this) {
      case AppRoutes.auth:
        return '/auth';
      case AppRoutes.mainNav:
        return '/main';
      case AppRoutes.webApp:
        return '/web-app';
    }
  }
}
