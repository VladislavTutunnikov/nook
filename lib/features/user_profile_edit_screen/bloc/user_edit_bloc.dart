import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nook/api/models/user_model.dart';
import 'package:nook/api/repositories/user_repository.dart';

part 'user_edit_event.dart';
part 'user_edit_state.dart';

class UserEditBloc extends Bloc<UserEditEvent, UserEditState> {
  UserEditBloc({required this.userRepository, required this.user}) : super(UserEditInitial()) {
    on<DeleteAvatar>((event, emit) async {
      try {
        await userRepository.deleteAvatar();
        emit(AvatarDeleteSuccess());
      } catch (e) {
        emit(AvatarDeleteFailure());
      }
    });

    on<UpdateProfile>((event, emit) async {
      if (event.username.isEmpty) {
        emit(EmptyUsernameError());
        return;
      }

      if(user.username == event.username && user.bio == event.bio && event.avatarImg == null) {
        emit(UserProfileUpdated());
        return;
      }

      emit(UserProfileUpdateLoading());
      try {
        await userRepository.updateUserProfile(
          username: event.username,
          bio: event.bio,
          avatarPath: event.avatarImg?.path,
        );
        emit(UserProfileUpdated());
      } on UsernameTakenException catch (_) {
        emit(UsernameAlreadyTakenError());
      } catch (e) {
        emit(UserProfileUpdateLoadingFailure());
      }
    });
  }

  final UserRepository userRepository;
  final UserModel user;
}
