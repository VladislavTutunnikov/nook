import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nook/api/di/injection.dart';
import 'package:nook/api/repositories/auth_repository.dart';
import 'package:nook/features/auth_wrapper/bloc/auth_wrapper_bloc.dart';
import 'package:nook/router/router.dart';
import 'package:nook/shared/widgets/loading_dots.dart';


@RoutePage()
class AuthWrapperScreen extends StatefulWidget {
  const AuthWrapperScreen({super.key});

  @override
  State<AuthWrapperScreen> createState() => _AuthWrapperScreenState();
}

class _AuthWrapperScreenState extends State<AuthWrapperScreen> {
  final AuthWrapperBloc _authBloc = AuthWrapperBloc(getIt<AuthRepository>());

  @override
  void initState() {
    _authBloc.add(AuthCheckStatus());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthWrapperBloc, AuthWrapperState>(
        bloc: _authBloc,
        listener: (context, state) {
          if (state is AuthAuthenticatedState) {
            AutoRouter.of(context).replace(const MainRoute());
          } else if (state is AuthUnauthenticatedState) {
            AutoRouter.of(context).replace(const LoginRoute());
          }
        },
        child: const Center(child: LoadingDots()),
      ),
    );
  }
}
