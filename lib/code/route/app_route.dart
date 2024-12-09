import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tuit_data_encryption/feature/pages/login.dart';
import 'package:tuit_data_encryption/feature/pages/main_page.dart';
import 'package:tuit_data_encryption/feature/pages/refresh_password.dart';
import 'package:tuit_data_encryption/feature/pages/register.dart';
import 'package:tuit_data_encryption/feature/pages/splash.dart';
import 'app_route_name.dart';

final GlobalKey<NavigatorState> _appNavigatorKey = GlobalKey<NavigatorState>(debugLabel: "app-key");

class AppRouter {
  const AppRouter._();

  static final router = GoRouter(
    initialLocation: AppRouteName.splash,
    navigatorKey: _appNavigatorKey,
    routes: [
      GoRoute(path: AppRouteName.splash, builder: (context, state) => const Splash()),
      GoRoute(path: AppRouteName.main, builder: (context, state) => const MainPage()),
      GoRoute(
        path: AppRouteName.login,
        builder: (context, state) => const Login(),
        routes: [
          GoRoute(path: AppRouteName.register, builder: (context, state) => const Register()),
          GoRoute(path: AppRouteName.refreshPassword, builder: (context, state) => const RefreshPassword()),
        ]
      ),
    ],
  );
}
