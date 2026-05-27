part of 'nook_edit_bloc.dart';

abstract class NookEditState {}

class NookEditInitial extends NookEditState {}

class AvatarDeleteSuccess extends NookEditState {}

class AvatarDeleteFailure extends NookEditState {}

class NookUpdateLoading extends NookEditState {}

class NookUpdated extends NookEditState {}

class NookUpdateLoadingFailure extends NookEditState {}

class NameAlreadyTakenError extends NookEditState {}

class EmptyNameError extends NookEditState {}

class EmptyCategoryError extends NookEditState {}