part of 'nook_followers_bloc.dart';

abstract class NookFollowersEvent {}

class LoadFollowers extends NookFollowersEvent{
  LoadFollowers({
    this.isRefresh = false,
    this.limit = 20,
    this.offset = 0,
  });

  final bool isRefresh;
  final int limit;
  final int offset;
}
