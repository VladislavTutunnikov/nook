part of 'followed_nooks_bloc.dart';

abstract class FollowedNooksState {}

class FollowedNooksInitial extends FollowedNooksState {}

class FollowedNooksLoading extends FollowedNooksState {}

class FollowedNooksLoaded extends FollowedNooksState {
  FollowedNooksLoaded({
    required this.followedNooks,
    required this.hasMore,
    required this.offset,
  });

  final List<NookModel> followedNooks;
  final bool hasMore;
  final int offset;
}

class FollowedNooksLoadingFailure extends FollowedNooksState {
  FollowedNooksLoadingFailure({required this.error});

  final String error;
}
