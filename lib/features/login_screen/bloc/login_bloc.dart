import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nook/api/repositories/auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this.authRepository) : super(LoginInitial()) {

    on<LoginSubmitted>((event, emit) async {
      emit(LoginLoading());
      try {
        await authRepository.login(event.login, event.password);
        emit(LoginSuccess());
      } catch (e) {
        emit(LoginFailure(e.toString()));
      }
    });

  }

  final AuthRepository authRepository;
}
