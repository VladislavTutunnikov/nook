import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nook/api/models/user_model.dart';
import 'package:nook/api/repositories/user_repository.dart';

part 'setup_profile_event.dart';
part 'setup_profile_state.dart';

class SetupProfileBloc extends Bloc<SetupProfileEvent, SetupProfileState> {
  SetupProfileBloc({required this.userRepository})
    : super(SetupProfileInitial()) {
    on<GetCurrentUser>((event, emit) async {
      emit(SetupProfileLoading());

      try {
        final UserModel user = await userRepository.getUser();
        emit(SetupProfileLoaded(user: user));
      } catch (e) {
        emit(SetupProfileLoadingFailure(message: e.toString()));
      }
    });
  }

  final UserRepository userRepository;
}
