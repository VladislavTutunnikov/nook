part of 'sign_up_bloc.dart';

abstract class SignUpEvent {}

class SignUp extends SignUpEvent {
  SignUp({required this.username, required this.email, required this.password});

  final String username;
  final String email;
  final String password;
}
