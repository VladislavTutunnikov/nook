part of 'sign_up_bloc.dart';

abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {}

class SignUpFailure extends SignUpState {
  SignUpFailure({required this.message});
  final String message;
}

class ShortPasswordError extends SignUpState {}

class EmailValidateError extends SignUpState {}

class UsernameTakenError extends SignUpState {}

class EmailTakenError extends SignUpState {}
