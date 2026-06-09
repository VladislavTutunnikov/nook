part of 'post_comments_bloc.dart';

abstract class PostCommentsState {}

class PostCommentsInitial extends PostCommentsState {}

class PostCommentsLoading extends PostCommentsState {}

class PostCommentsLoaded extends PostCommentsState {
  PostCommentsLoaded({required this.comments, required this.hasMore, required this.offset});
  final List<CommentModel> comments;
  final bool hasMore;
  final int offset;
}

class PostCommentsLoadingFailure extends PostCommentsState {
  PostCommentsLoadingFailure({required this.message});
  final String message;
}
