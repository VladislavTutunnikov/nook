part of 'account_bloc.dart';

abstract class AccountEvent {}

class LoadAccountData extends AccountEvent {
  LoadAccountData({this.completer});

  final Completer? completer;
}

class LoadAccountPosts extends AccountEvent {}
