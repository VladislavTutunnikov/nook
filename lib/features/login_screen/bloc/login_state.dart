part of 'login_bloc.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  LoginFailure(this.message);

  final String message;
}

class ShortPasswordError extends LoginState {}

class InvalidLoginOrPasswordError extends LoginState {}

class AccountBannedError extends LoginState {}
