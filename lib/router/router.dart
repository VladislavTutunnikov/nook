
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nook/features/account_screen/view/account_screen.dart';
import 'package:nook/features/auth_wrapper/view/auth_wrapper_screen.dart';
import 'package:nook/features/login_screen/view/login_screen.dart';
import 'package:nook/features/main_screen/view/main_screen.dart';
import 'package:nook/features/nook_rules_screen/view/nook_rules_screen.dart';
import 'package:nook/features/nook_screen/view/nook_screen.dart';
import 'package:nook/features/nook_team_screen/view/nook_team_screen.dart';
part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter  {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: AuthWrapperRoute.page, path: '/'),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: MainRoute.page),
    AutoRoute(page: AccountRoute.page),
    AutoRoute(page: NookRoute.page),
    AutoRoute(page: NookRulesRoute.page),
    AutoRoute(page: NookTeamRoute.page),
  ];
}