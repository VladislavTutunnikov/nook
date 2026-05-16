
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nook/features/account_screen/view/account_screen.dart';
import 'package:nook/features/auth_wrapper/view/auth_wrapper_screen.dart';
import 'package:nook/features/login_screen/view/login_screen.dart';
import 'package:nook/features/main_screen/view/main_screen.dart';
part 'router.gr.dart';

// final routes = {
//   '/': (context) => const AuthWrapper(),
//   '/login': (context) => const LoginScreen(),
//   '/main': (context) => const MainScreen(),
// };


@AutoRouterConfig()
class AppRouter extends RootStackRouter  {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: AuthWrapperRoute.page, path: '/'),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: MainRoute.page),
    AutoRoute(page: AccountRoute.page),
  ];
}