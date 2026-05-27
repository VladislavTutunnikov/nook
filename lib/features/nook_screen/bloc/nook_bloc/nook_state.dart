part of 'nook_bloc.dart';

abstract class NookState {}

class NookInitial extends NookState {}

class NookLoading extends NookState {}

class NookLoaded extends NookState {
  NookLoaded({
    required this.nook,
    required this.isFollowed,
    required this.followersCount,
    required this.isOwner,
    required this.isModerator,
  });

  final NookModel nook;
  final bool isFollowed;
  final int followersCount;
  final bool isOwner;
  final bool isModerator;
}

class NookLoadingFailure extends NookState {
  NookLoadingFailure({required this.error});
  final String error;
}

class NookDeleteSuccess extends NookState {}
