import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nook/api/repositories/auth_repository.dart';
import 'package:nook/api/repositories/user_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({required this.authRepository}) : super(SignUpInitial()) {
    on<SignUp>((event, emit) async {
      if (event.password.length < 8) {
        emit(ShortPasswordError());
        return;
      }

      if (!EmailValidator.validate(event.email)) {
        emit(EmailValidateError());
        return;
      }

      emit(SignUpLoading());

      try {
        await authRepository.register(
          email: event.email,
          username: event.username,
          password: event.password,
        );
        emit(SignUpSuccess());
      } on UsernameTakenException catch (_) {
        emit(UsernameTakenError());
      } on EmailTakenException catch (_) {
        emit(EmailTakenError());
      } catch (e) {
        emit(SignUpFailure(message: e.toString()));
      }
    });
  }

  final AuthRepository authRepository;
}
