import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/models/event.dart';
import 'package:myapp/view_models/home_cubit.dart';
import 'package:myapp/view_models/login_cubit.dart';
import 'package:myapp/views/event/event_detail_screen.dart';
import 'package:myapp/views/home/home_screen.dart';
import 'package:myapp/views/login/login_screen.dart';

enum AppRoute {
  login,
  home,
  eventDetail
}

extension AppRouteExt on AppRoute {
  String? get name {
    switch (this) {
      case AppRoute.login:
        return '/login';
      case AppRoute.home:
        return '/home';
      case AppRoute.eventDetail:
        return '/eventDetail';
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
          bindings: [BindingsBuilder.put(()=> LoginCubit(Get.find()))],
        );
      case AppRoute.home:
        return GetPageRoute(
          settings: settings,
          page: () => const HomeScreen(),
          bindings: [BindingsBuilder.put(()=> HomeCubit(Get.find()))],
        );
      case AppRoute.eventDetail:
        return GetPageRoute(
          settings: settings,
          page: () => EventDetailScreen(event: settings.arguments as Event),
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
