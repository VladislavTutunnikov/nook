part of 'setup_profile_bloc.dart';

abstract class SetupProfileState {}

class SetupProfileInitial extends SetupProfileState {}

class SetupProfileLoading extends SetupProfileState {}

class SetupProfileLoaded extends SetupProfileState {
  SetupProfileLoaded({required this.user});
  final UserModel user;
}

class SetupProfileLoadingFailure extends SetupProfileState {
  SetupProfileLoadingFailure({required this.message});
  final String message;
}
