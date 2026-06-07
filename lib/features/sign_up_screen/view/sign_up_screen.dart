import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nook/api/di/injection.dart';
import 'package:nook/api/repositories/auth_repository.dart';
import 'package:nook/features/sign_up_screen/bloc/sign_up_bloc.dart';
import 'package:nook/features/sign_up_screen/widgets/sign_up_form.dart';
import 'package:nook/generated/l10n.dart';
import 'package:nook/router/router.dart';
import 'package:nook/shared/widgets/capsule_button.dart';
import 'package:nook/shared/widgets/custom_back_button.dart';
import 'package:nook/shared/widgets/loading_dots.dart';
import 'package:nook/shared/widgets/network_error_dialog.dart';
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

  final SignUpBloc _signUpBloc = SignUpBloc(
    authRepository: getIt<AuthRepository>(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SignUpBloc, SignUpState>(
        bloc: _signUpBloc,
        listener: (context, state) {
          if (state is SignUpFailure) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const NetworkErrorDialog();
              },
            );
          } else if (state is ShortPasswordError) {
            setState(() {
              _passwordErrorText = S.of(context).passwordTooShort;
            });
          } else if (state is EmailValidateError) {
            setState(() {
              _emailErrorText = S.of(context).uncorrectEmail;
            });
          } else if (state is UsernameTakenError) {
            setState(() {
              _usernameErrorText = S.of(context).usernameAlreadyTakenError;
            });
          } else if (state is EmailTakenError) {
            _emailErrorText = S.of(context).emailAlreadyTakenError;
          } else if (state is SignUpSuccess) {
            AutoRouter.of(context).push(const MainRoute());
          }
        },
        child: BlocBuilder<SignUpBloc, SignUpState>(
          bloc: _signUpBloc,
          builder: (context, state) {
            if (state is SignUpLoading) {
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
                      Row(
                        children: [
                          const CustomBackButton(
                            color: AppColors.black,
                            size: 30,
                          ),
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
                        usernameErrorText: _usernameErrorText,
                        emailErrorText: _emailErrorText,
                        passwordErrorText: _passwordErrorText,
                      ),
                      const SizedBox(height: 20),
                      CapsuleButton(
                        text: S.of(context).createAccount,
                        padding: const EdgeInsets.all(13),
                        centerText: true,
                        textStyle: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(color: AppColors.white),
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

                          setState(() {
                            _usernameErrorText = null;
                            _emailErrorText = null;
                            _passwordErrorText = null;
                          });

                          _signUpBloc.add(
                            SignUp(
                              username: _usernameController.text,
                              email: _emailController.text,
                              password: _passwordController.text,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
