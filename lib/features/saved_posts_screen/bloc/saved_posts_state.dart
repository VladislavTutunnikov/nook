part of 'saved_posts_bloc.dart';

abstract class SavedPostsState {}

class SavedPostsInitial extends SavedPostsState {}

class SavedPostsLoading extends SavedPostsState {}

class SavedPostsLoaded extends SavedPostsState {
  SavedPostsLoaded({
    required this.savedPosts,
    required this.hasMore,
    required this.offset,
  });

  final List<PostModel> savedPosts;
  final bool hasMore;
  final int offset;
}

class SavedPostsLoadingFailure extends SavedPostsState {
  SavedPostsLoadingFailure({required this.error});

  final String error;
}
