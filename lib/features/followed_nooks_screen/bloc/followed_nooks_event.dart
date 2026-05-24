part of 'followed_nooks_bloc.dart';

abstract class FollowedNooksEvent {}

class LoadFollowedNooks extends FollowedNooksEvent {
  LoadFollowedNooks({this.isRefresh = false, this.limit = 20, this.offset = 0});

  final bool isRefresh;
  final int limit;
  final int offset;
}
