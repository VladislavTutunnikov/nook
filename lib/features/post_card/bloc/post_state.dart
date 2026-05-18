part of 'post_bloc.dart';

abstract class PostState {}

class PostInitial extends PostState {}

class PostUpdated extends PostState {
  PostUpdated({
    required this.isLiked,
    required this.isReposted,
    required this.isSaved,
    required this.isPinned,
    required this.likeCount,
    required this.repostCount,
    required this.canDelete,
    required this.canEdit,
    required this.canPin,
  });

  final bool isLiked;
  final bool isReposted;
  final bool isSaved;
  final bool isPinned;
  final int likeCount;
  final int repostCount;
  final bool canDelete;
  final bool canEdit;
  final bool canPin;
}

class PostDeleted extends PostState {}
