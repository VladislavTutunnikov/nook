part of 'nook_bloc.dart';

abstract class NookEvent {}

class LoadNookData extends NookEvent{}

class FollowNook extends NookEvent {}

class DeleteNook extends NookEvent {}