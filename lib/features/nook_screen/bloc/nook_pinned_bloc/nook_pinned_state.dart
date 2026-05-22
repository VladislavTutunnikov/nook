part of 'nook_pinned_bloc.dart';

abstract class NookPinnedState {}

class NookPinnedInitial extends NookPinnedState {}

class NookPinnedPostsLoaded extends NookPinnedState {
  NookPinnedPostsLoaded({
    required this.posts,
    required this.hasMore,
    required this.offset,
  });

  final List<PostModel> posts;
  final bool hasMore;
  final int offset;
}

class NookPinnedPostsLoadingFailure extends NookPinnedState {
  NookPinnedPostsLoadingFailure({required this.error});
  final String error;
}
