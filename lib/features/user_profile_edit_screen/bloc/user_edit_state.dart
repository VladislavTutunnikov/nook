part of 'user_edit_bloc.dart';

abstract class UserEditState {}

class UserEditInitial extends UserEditState {}

class AvatarDeleteSuccess extends UserEditState {}

class AvatarDeleteFailure extends UserEditState {}

class UserProfileUpdateLoading extends UserEditState {}

class UserProfileUpdated extends UserEditState {}

class UserProfileUpdateLoadingFailure extends UserEditState {}

class UsernameAlreadyTakenError extends UserEditState {}

class EmptyUsernameError extends UserEditState {}