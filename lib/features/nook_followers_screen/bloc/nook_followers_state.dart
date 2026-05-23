part of 'nook_followers_bloc.dart';

abstract class NookFollowersState {}

class NookFollowersInitial extends NookFollowersState {}

class NookFollowersLoading extends NookFollowersState {}

class NookFollowersLoaded extends NookFollowersState {
  NookFollowersLoaded({
    required this.followers,
    required this.hasMore,
    required this.offset,
  });

  final List<NookMemberModel> followers;
  final bool hasMore;
  final int offset;
}

class NookFollowersLoadingFailure extends NookFollowersState {
  NookFollowersLoadingFailure({required this.error});

  final String error;
}
