part of 'account_bloc.dart';

abstract class AccountState {}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class AccountLoaded extends AccountState {
  AccountLoaded({required this.user, required this.followingUrls});
  final UserModel user;
  final List<String> followingUrls;
}

class AccountLoadFailure extends AccountState {
  AccountLoadFailure({required this.error});
  final String error;
}
