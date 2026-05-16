part of 'content_bloc.dart';

abstract class ContentState {}

class ContentInitial extends ContentState {}

class PostsLoaded extends ContentState {
  PostsLoaded({
    required this.posts,
    required this.hasMore,
    required this.offset,
  });
  final List<PostModel> posts;
  final bool hasMore;
  final int offset;
}

class CommentsLoaded extends ContentState {
  CommentsLoaded({
    required this.comments,
    required this.hasMore,
    required this.offset,
  });
  final List<CommentModel> comments;
  final bool hasMore;
  final int offset;
}

class ContentLoadFailure extends ContentState {
  ContentLoadFailure({required this.error});
  final String error;
}
