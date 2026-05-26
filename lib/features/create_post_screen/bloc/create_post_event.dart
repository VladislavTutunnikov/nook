part of 'create_post_bloc.dart';

abstract class CreatePostEvent {}

class SendPost extends CreatePostEvent {
  SendPost({
    required this.nookId,
    required this.title,
    required this.content,
    required this.images,
  });

  final String? nookId;
  final String title;
  final String? content;
  final List<XFile> images;
}
