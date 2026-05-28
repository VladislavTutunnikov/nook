part of 'feed_bloc.dart';

abstract class FeedState {}

class FeedInitial extends FeedState {}

class FeedLoading extends FeedState {}

class FeedLoaded extends FeedState {
  FeedLoaded({
    required this.posts,
    required this.hasMore,
    required this.offset,
  });

  final List<PostModel> posts;
  final bool hasMore;
  final int offset;
}

class FeedLoadingFailure extends FeedState {
  FeedLoadingFailure({required this.error});

  final String error;
}
