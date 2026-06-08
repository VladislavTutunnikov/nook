import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nook/api/di/injection.dart';
import 'package:nook/api/repositories/auth_repository.dart';
import 'package:nook/features/login_screen/bloc/login_bloc.dart';
import 'package:nook/features/login_screen/widgets/account_banned_dialog.dart';
import 'package:nook/features/login_screen/widgets/login_form.dart';
import 'package:nook/features/login_screen/widgets/login_header.dart';
import 'package:nook/generated/l10n.dart';
import 'package:nook/router/router.dart';
import 'package:nook/shared/widgets/capsule_button.dart';
import 'package:nook/shared/widgets/loading_dots.dart';
import 'package:nook/shared/widgets/network_error_dialog.dart';
import 'package:nook/theme/colors.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginBloc = LoginBloc(getIt<AuthRepository>());

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  String? _errorMessage;

  DateTime? _lastPressed;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        final now = DateTime.now();

        if (_lastPressed == null ||
            now.difference(_lastPressed!) > const Duration(seconds: 2)) {
          _lastPressed = now;
          return;
        }

        await SystemNavigator.pop();
      },
      child: Scaffold(
        body: BlocListener<LoginBloc, LoginState>(
          bloc: _loginBloc,
          listener: (context, state) {
            if (state is ShortPasswordError) {
              setState(() {
                _errorMessage = S.of(context).passwordTooShort;
              });
            } else if (state is InvalidLoginOrPasswordError) {
              setState(() {
                _errorMessage = S.of(context).invalidLoginOrPassword;
              });
            } else if (state is AccountBannedError) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const AccountBannedDialog();
                },
              );
            } else if (state is LoginFailure) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const NetworkErrorDialog();
                },
              );
            } else if (state is LoginSuccess) {
              AutoRouter.of(context).replaceAll([const MainRoute()]);
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            bloc: _loginBloc,
            builder: (context, state) {
              if (state is LoginLoading) {
                return const Center(child: LoadingDots());
              }
              return Padding(
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
                        const LoginHeader(),
                        const SizedBox(height: 20),
                        LoginForm(
                          usernameController: _usernameController,
                          passwordController: _passwordController,
                          usernameFocusNode: _usernameFocusNode,
                          passwordFocusNode: _passwordFocusNode,
                        ),
                        _errorMessage != null
                            ? Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  _errorMessage!,
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(color: AppColors.darkRed),
                                ),
                              )
                            : const SizedBox(),
                        const SizedBox(height: 20),
                        CapsuleButton(
                          text: S.of(context).logIn,
                          padding: const EdgeInsets.all(13),
                          centerText: true,
                          textStyle: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(color: AppColors.white),
                          onTap: () {
                            if (_usernameController.text.isEmpty) {
                              _usernameFocusNode.requestFocus();
                              return;
                            }
                            if (_passwordController.text.isEmpty) {
                              _passwordFocusNode.requestFocus();
                              return;
                            }

                            _loginBloc.add(
                              LoginSubmitted(
                                login: _usernameController.text,
                                password: _passwordController.text,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        CapsuleButton(
                          onTap: () =>
                              AutoRouter.of(context).push(const SignUpRoute()),
                          text: S.of(context).noAccountYet,
                          padding: const EdgeInsets.all(13),
                          centerText: true,
                          textStyle: Theme.of(context).textTheme.titleMedium,
                          backgroundColor: AppColors.white,
                          border: Border.all(width: 1, color: AppColors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
