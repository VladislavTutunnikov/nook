part of 'post_comments_bloc.dart';

abstract class PostCommentsEvent {}

class LoadPostComments extends PostCommentsEvent {
  LoadPostComments({
    this.isRefresh = false,
    this.limit = 20,
    this.offset = 0,
  });

  final bool isRefresh;
  final int limit;
  final int offset;
}
