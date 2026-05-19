part of 'account_bloc.dart';

abstract class AccountEvent {}

class LoadAccountData extends AccountEvent {
  LoadAccountData({this.completer});

  final Completer? completer;
}

class Logout extends AccountEvent {
  Logout(this.context);
  final BuildContext context;
}
