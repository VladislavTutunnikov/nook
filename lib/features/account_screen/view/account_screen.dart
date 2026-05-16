import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nook/features/main_screen/pages/account_page/view/account_page.dart';


@RoutePage()
class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key, required this.userId});
  final String userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: AccountPage(userId: userId,));
  }
}