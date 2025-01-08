import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:myapp/constant/constant.dart';
import 'package:myapp/shared/app_route.dart';
import 'package:myapp/theme/app_theme.dart';
import 'package:myapp/theme/custom_theme.dart';
import 'package:myapp/utils/dependencies.dart';

void main() {
  provideDependencies();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalManager _globalManager = Get.find();
  final RouteObserverService routeObserver = RouteObserverService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      behavior: HitTestBehavior.translucent,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: _globalManager.navigatorKey,
        theme: CustomTheme.fromContext(context).oneAppTheme,
        initialRoute: AppRoute.login.name!,
        navigatorObservers: [routeObserver],
        builder: EasyLoading.init(
          builder: (context, child) {
            return MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: TextScaler.noScaling),
                child: AppTheme(child: child!));
          },
        ),
        onGenerateRoute: AppRouteExt.generateRoute,
      ),
    );
  }
}

class RouteObserverService extends NavigatorObserver {
  static final RouteObserverService _singleton =
      RouteObserverService._internal();

  factory RouteObserverService() {
    return _singleton;
  }

  RouteObserverService._internal();

  String _currentRoute = '/';
  String get currentRoute => _currentRoute;

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    _currentRoute = route.settings.name ?? '/';
    debugPrint('Current route: $_currentRoute');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    _currentRoute = previousRoute?.settings.name ?? '/';
    debugPrint('Current route: $_currentRoute');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _currentRoute = newRoute?.settings.name ?? '/';
    debugPrint('Current route: $_currentRoute');
  }
}
