import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/views/login/login_screen.dart';

enum AppRoute {
  login,
}

extension AppRouteExt on AppRoute {
  String? get name {
    switch (this) {
      case AppRoute.login:
        return '/login';
      default:
        return null;
    }
  }

  static AppRoute? from(String? name) {
    for (final item in AppRoute.values) {
      if (item.name == name) {
        return item;
      }
    }
    return null;
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (AppRouteExt.from(settings.name)) {
      case AppRoute.login:
        return GetPageRoute(
          settings: settings,
          page: () => const LoginScreen(),
          bindings: [],
        );
      default:
        return GetPageRoute(
          settings: settings,
          page: () => Scaffold(
            appBar: AppBar(),
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
