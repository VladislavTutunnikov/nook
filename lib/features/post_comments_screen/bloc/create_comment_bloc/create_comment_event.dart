part of 'create_comment_bloc.dart';

abstract class CreateCommentEvent {}

class CreateComment extends CreateCommentEvent {
  CreateComment({required this.content});

  final String content;
}
