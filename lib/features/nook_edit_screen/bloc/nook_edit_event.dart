part of 'nook_edit_bloc.dart';

abstract class NookEditEvent {}

class DeleteAvatar extends NookEditEvent {}

class UpdateNook extends NookEditEvent {
  UpdateNook({
    required this.name,
    required this.description,
    required this.rules,
    required this.categoryId,
    required this.avatarImg,
  });

  final String name;
  final String description;
  final String rules;
  final String? categoryId;
  final XFile? avatarImg;
}