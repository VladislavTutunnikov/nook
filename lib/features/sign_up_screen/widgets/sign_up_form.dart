import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nook/generated/l10n.dart';
import 'package:nook/shared/widgets/password_field.dart';
import 'package:nook/theme/colors.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
    required this.usernameController,
    required this.passwordController,
    required this.usernameFocusNode,
    required this.passwordFocusNode,
    required this.emailController,
    required this.emailFocusNode,
    this.usernameErrorText,
    this.emailErrorText,
    this.passwordErrorText,
  });
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final FocusNode usernameFocusNode;
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;
  final String? usernameErrorText;
  final String? emailErrorText;
  final String? passwordErrorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).whatCanWeCallYou,
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
        usernameErrorText != null
            ? Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  usernameErrorText!,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: AppColors.darkRed),
                ),
              )
            : const SizedBox(),
        const SizedBox(height: 10),
        Text(
          S.of(context).yourEmail,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: AppColors.darkGrey),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: emailController,
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp(r'\s')),
            FilteringTextInputFormatter.deny(RegExp(r'[а-яА-ЯёЁ]')),
          ],
          focusNode: emailFocusNode,
          style: Theme.of(context).textTheme.bodyLarge,
          decoration: InputDecoration(
            hint: Text(
              S.of(context).email,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.darkGrey),
            ),
          ),
        ),
        emailErrorText != null
            ? Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  emailErrorText!,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: AppColors.darkRed),
                ),
              )
            : const SizedBox(),
        const SizedBox(height: 10),
        Text(
          S.of(context).thinkPassword,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: AppColors.darkGrey),
        ),
        const SizedBox(height: 5),
        PasswordField(
          controller: passwordController,
          focusNode: passwordFocusNode,
        ),
        passwordErrorText != null
            ? Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  passwordErrorText!,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: AppColors.darkRed),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
