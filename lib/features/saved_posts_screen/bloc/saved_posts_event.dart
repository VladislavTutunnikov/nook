part of 'saved_posts_bloc.dart';

abstract class SavedPostsEvent {}

class LoadSavedPosts extends SavedPostsEvent {
  LoadSavedPosts({
    this.isRefresh = false,
    this.limit = 20,
    this.offset = 0,
  });

  final bool isRefresh;
  final int limit;
  final int offset;
}