part of 'nook_posts_bloc.dart';

abstract class NookPostsEvent {}

class LoadNookPosts extends NookPostsEvent {
  LoadNookPosts({
    this.isRefresh = false,
    this.filter = PostFilter.byPopularity,
    this.limit = 20,
    this.offset = 0,
  });

  final bool isRefresh;
  final PostFilter filter;
  final int limit;
  final int offset;
}
