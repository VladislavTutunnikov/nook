part of 'member_bloc.dart';

abstract class MemberState {}

class MemberInitial extends MemberState {}

class MemberUpdated extends MemberState {
  MemberUpdated({required this.isBanned, required this.memberRole});

  final bool isBanned;
  final MemberRole memberRole;
}
