part of 'nook_team_bloc.dart';

abstract class NookTeamState {}

class NookTeamInitial extends NookTeamState {}

class NookTeamLoading extends NookTeamState {}

class NookTeamLoaded extends NookTeamState {
  NookTeamLoaded({required this.owner, required this.moderators});

  final NookMemberModel? owner;
  final List<NookMemberModel>? moderators;
}

class NookTeamLoadingFailure extends NookTeamState {
  NookTeamLoadingFailure({required this.error});

  final String error;
}
