part of 'nook_posts_bloc.dart';

abstract class NookPostsState {}

class NookPostsInitial extends NookPostsState {}

class NookPostsLoaded extends NookPostsState {
  NookPostsLoaded({
    required this.posts,
    required this.hasMore,
    required this.offset,
  });
  final List<PostModel> posts;
  final bool hasMore;
  final int offset;
}

class NookPostsLoadingFailure extends NookPostsState {
  NookPostsLoadingFailure({required this.error});

  final String error;
}
