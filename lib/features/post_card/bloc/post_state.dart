part of 'post_bloc.dart';

abstract class PostState {}

class PostInitial extends PostState {}

class PostUpdated extends PostState {
  PostUpdated({
    required this.isLiked,
    required this.isReposted,
    required this.isSaved,
    required this.likeCount,
    required this.repostCount,
  });
  
  final bool isLiked;
  final bool isReposted;
  final bool isSaved;
  final int likeCount;
  final int repostCount;
}
