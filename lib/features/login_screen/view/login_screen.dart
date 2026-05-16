import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nook/api/di/injection.dart';
import 'package:nook/api/repositories/auth_repository.dart';
import 'package:nook/features/login_screen/bloc/login_bloc.dart';
import 'package:nook/router/router.dart';
import 'package:nook/shared/widgets/loading_dots.dart';
import 'package:nook/theme/colors.dart';


@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginBloc = LoginBloc(getIt<AuthRepository>());

  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  //TODO: add stings to ARB
  //TODO: refactor this screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        bloc: _loginBloc,
        listener: (context, state) {
          if (state is LoginSuccess) {
            AutoRouter.of(context).replace(const MainRoute());
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          bloc: _loginBloc,
          builder: (context, state) {
            if (state is LoginLoading) {
              return const Center(child: LoadingDots());
            }
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    state is LoginFailure
                        ? const Text(
                            'Ошибка входа\n',
                            style: TextStyle(
                              color: AppColors.red,
                              fontSize: 15,
                            ),
                          )
                        : const SizedBox(),

                    const Text('Логин'),
                    TextField(controller: _loginController),
                    const SizedBox(height: 20),
                    const Text('Пароль'),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      obscuringCharacter: '•',
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: AlignmentGeometry.center,
                      child: ElevatedButton(
                        style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            AppColors.black,
                          ),
                        ),
                        onPressed: () => _loginBloc.add(
                          LoginSubmitted(
                            login: _loginController.text,
                            password: _passwordController.text,
                          ),
                        ),
                        child: const Text(
                          'Войти',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
