part of 'post_form_bloc.dart';

abstract class PostFormEvent {}

class SendPost extends PostFormEvent {
  SendPost({
    required this.nookId,
    required this.title,
    required this.content,
    required this.images,
  });

  final String? nookId;
  final String title;
  final String? content;
  final List<String> images;
}

class UpdatePost extends PostFormEvent {
  UpdatePost({
    required this.title,
    required this.content,
    required this.images,
    required this.imagesToRemove,
  });

  final String title;
  final String? content;
  final List<String> images;
  final List<String> imagesToRemove;
}
