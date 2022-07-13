enum AppRoutes { auth, mainNav, webApp, createEvent }

extension ToRoute on AppRoutes {
  String toRoute() {
    switch (this) {
      case AppRoutes.auth:
        return '/auth';
      case AppRoutes.mainNav:
        return '/main';
      case AppRoutes.createEvent:
        return '/create-event';
      case AppRoutes.webApp:
        return '/web-app';
    }
  }
}
