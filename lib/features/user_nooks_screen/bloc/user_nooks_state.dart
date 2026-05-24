part of 'user_nooks_bloc.dart';

abstract class UserNooksState {}

class UserNooksInitial extends UserNooksState {}

class UserNooksLoading extends UserNooksState {}

class UserNooksLoaded extends UserNooksState {
  UserNooksLoaded({
    required this.nooks,
    required this.hasMore,
    required this.offset,
  });

  final List<NookModel> nooks;
  final bool hasMore;
  final int offset;
}

class UserNooksLoadingFailure extends UserNooksState {
  UserNooksLoadingFailure({required this.error});

  final String error;
}
