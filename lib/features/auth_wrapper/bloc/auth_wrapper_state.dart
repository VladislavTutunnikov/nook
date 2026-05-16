part of 'auth_wrapper_bloc.dart';

abstract class AuthWrapperState {}

class AuthWrapperInitialState extends AuthWrapperState {}

class AuthWrapperLoadingState extends AuthWrapperState {}

class AuthAuthenticatedState extends AuthWrapperState {}

class AuthUnauthenticatedState extends AuthWrapperState {}
