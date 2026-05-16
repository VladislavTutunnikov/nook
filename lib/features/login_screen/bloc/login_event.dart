part of 'login_bloc.dart';

abstract class LoginEvent {}

class LoginSubmitted extends LoginEvent {
  LoginSubmitted({required this.login, required this.password});
  
  final String login;
  final String password;
}