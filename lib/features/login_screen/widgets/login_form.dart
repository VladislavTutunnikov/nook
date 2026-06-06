import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nook/generated/l10n.dart';
import 'package:nook/shared/widgets/password_field.dart';
import 'package:nook/theme/colors.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.usernameController,
    required this.passwordController, required this.usernameFocusNode, required this.passwordFocusNode,
  });
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final FocusNode usernameFocusNode;
  final FocusNode passwordFocusNode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).usernameOrEmail,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: AppColors.darkGrey),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: usernameController,
           inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9_.-]')),
              FilteringTextInputFormatter.deny(RegExp(r'\s')),
            ],
          focusNode: usernameFocusNode,
          style: Theme.of(context).textTheme.bodyLarge,
          decoration: InputDecoration(
            hint: Text(
              S.of(context).username,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.darkGrey),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          S.of(context).password,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: AppColors.darkGrey),
        ),
        const SizedBox(height: 5),
        PasswordField(controller: passwordController, focusNode: passwordFocusNode,),
      ],
    );
  }
}
