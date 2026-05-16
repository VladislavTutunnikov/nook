import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nook/api/models/user_model.dart';
import 'package:nook/api/repositories/user_repository.dart';
part 'account_state.dart';
part 'account_event.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc({required this.userRepository, this.userId}) : super(AccountInitial()) {
    on<LoadAccountData>((event, emit) async {
      if (state is! AccountLoaded) {
        emit(AccountLoading());
      }

      try {
        final userData = await userRepository.getUser(userId: userId);
        final followingUrls = await userRepository.getUserFollowingAvatars(userId: userId);

        emit(AccountLoaded(user: userData, followingUrls: followingUrls));
      } catch (e) {
        emit(AccountLoadFailure(error: e.toString()));
      } finally {
        event.completer?.complete();
      }
    });
  }

  final String? userId;
  final UserRepository userRepository;
}
