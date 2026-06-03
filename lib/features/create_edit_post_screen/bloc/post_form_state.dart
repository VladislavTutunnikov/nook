part of 'post_form_bloc.dart';

abstract class PostFormState {}

class PostFormInitial extends PostFormState {}

class PostLoading extends PostFormState {}

class PostLoadingFailure extends PostFormState {}

class PostTitleError extends PostFormState {}

class PostNookIdError extends PostFormState {}

class PostLoaded extends PostFormState {}
