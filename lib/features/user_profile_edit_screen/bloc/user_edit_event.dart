part of 'user_edit_bloc.dart';

abstract class UserEditEvent {}

class DeleteAvatar extends UserEditEvent {}

class UpdateProfile extends UserEditEvent {
  UpdateProfile({
    required this.username,
    required this.bio,
    required this.avatarImg,
  });

  final String username;
  final String bio;
  final XFile? avatarImg;
}
