part of 'nook_pinned_bloc.dart';

abstract class NookPinnedEvent {}

class LoadNookPinnedPosts extends NookPinnedEvent{
   LoadNookPinnedPosts({
    this.isRefresh = false,
    this.limit = 20,
    this.offset = 0,
  });

  final bool isRefresh;
  final int limit;
  final int offset;
}