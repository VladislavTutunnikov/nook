part of 'member_bloc.dart';

abstract class MemberEvent {}

class SetupData extends MemberEvent {}

class BanMember extends MemberEvent {}

class MakeModerator extends MemberEvent {}