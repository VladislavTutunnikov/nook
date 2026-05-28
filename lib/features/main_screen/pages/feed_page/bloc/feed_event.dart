part of 'feed_bloc.dart';

abstract class FeedEvent {}

class LoadFeed extends FeedEvent {
  LoadFeed({
    this.isRefresh = false,
    this.limit = 40,
    this.offset = 0,
  });

  final bool isRefresh;
  final int limit;
  final int offset;
}