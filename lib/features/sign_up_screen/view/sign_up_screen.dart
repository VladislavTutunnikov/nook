import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nook/features/sign_up_screen/widgets/sign_up_form.dart';
import 'package:nook/generated/l10n.dart';
import 'package:nook/shared/widgets/capsule_button.dart';
import 'package:nook/shared/widgets/custom_back_button.dart';
import 'package:nook/theme/colors.dart';

@RoutePage()
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  String? _usernameErrorText;
  String? _emailErrorText;
  String? _passwordErrorText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Container(
            padding: const EdgeInsets.only(
              top: 30,
              left: 20,
              right: 20,
              bottom: 20,
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(color: AppColors.lightGrey, width: 1),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const CustomBackButton(color: AppColors.black, size: 30),
                    const Spacer(),
                    Text(
                      S.of(context).registerWithNook,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Spacer(),
                    const SizedBox(width: 30),
                  ],
                ),

                const SizedBox(height: 20),
                SignUpForm(
                  usernameController: _usernameController,
                  emailController: _emailController,
                  passwordController: _passwordController,
                  usernameFocusNode: _usernameFocusNode,
                  emailFocusNode: _emailFocusNode,
                  passwordFocusNode: _passwordFocusNode,
                ),
                const SizedBox(height: 20),
                CapsuleButton(
                  text: S.of(context).createAccount,
                  padding: const EdgeInsets.all(13),
                  centerText: true,
                  textStyle: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: AppColors.white),
                  onTap: () {
                    if (_usernameController.text.isEmpty) {
                      _usernameFocusNode.requestFocus();
                      return;
                    }
                    if (_emailController.text.isEmpty) {
                      _emailFocusNode.requestFocus();
                      return;
                    }
                    if (_passwordController.text.isEmpty) {
                      _passwordFocusNode.requestFocus();
                      return;
                    }
                    // _loginBloc.add(
                    //   LoginSubmitted(
                    //     login: _usernameController.text,
                    //     password: _passwordController.text,
                    //   ),
                    // );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
