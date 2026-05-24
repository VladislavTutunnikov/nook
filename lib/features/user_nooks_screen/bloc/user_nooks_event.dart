part of 'user_nooks_bloc.dart';

abstract class UserNooksEvent {}

class LoadUserNooks extends UserNooksEvent {
  LoadUserNooks({this.isRefresh = false, this.limit = 20, this.offset = 0});

  final bool isRefresh;
  final int limit;
  final int offset;
}
