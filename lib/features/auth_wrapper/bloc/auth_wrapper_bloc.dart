import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nook/api/repositories/auth_repository.dart';

part 'auth_wrapper_event.dart';
part 'auth_wrapper_state.dart';

class AuthWrapperBloc extends Bloc<AuthWrapperEvent, AuthWrapperState> {
  AuthWrapperBloc(this.authRepository) : super(AuthWrapperInitialState()) {
    on<AuthCheckStatus>((event, emit) async {
      
      emit(AuthWrapperLoadingState());
      await Future.delayed(const Duration(seconds: 2));

      if (await authRepository.isAuthenticated()) {
        emit(AuthAuthenticatedState());
      } else {
        emit(AuthUnauthenticatedState());
      }
    });
  }

  final AuthRepository authRepository;
}
