part of 'create_post_bloc.dart';

abstract class CreatePostState {}

class CreatePostInitial extends CreatePostState {}

class CreatePostLoading extends CreatePostState {}

class CreatePostFailure extends CreatePostState {}

class CreatePostTitleError extends CreatePostState {}

class CreatePostNookIdError extends CreatePostState {}

class PostCreated extends CreatePostState {}