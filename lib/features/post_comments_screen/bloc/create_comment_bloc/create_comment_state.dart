part of 'create_comment_bloc.dart';

abstract class CreateCommentState {}

class CreateCommentInitial extends CreateCommentState {}

class CreateCommentLoading extends CreateCommentState {}

class CreateCommentLoaded extends CreateCommentState {}

class CreateCommentLoadingFailure extends CreateCommentState {
  CreateCommentLoadingFailure({required this.message});
  final String message;
}
