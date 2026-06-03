import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nook/api/repositories/post_repository.dart';

part 'post_form_event.dart';
part 'post_form_state.dart';

class PostFormBloc extends Bloc<PostFormEvent, PostFormState> {
  PostFormBloc({
    required this.postRepository,
    required this.baseUrl,
    this.postId,
  }) : super(PostFormInitial()) {
    on<SendPost>((event, emit) async {
      if (event.title.trim().isEmpty) {
        emit(PostTitleError());
        return;
      }
      if (event.nookId == null || event.nookId!.trim().isEmpty) {
        emit(PostNookIdError());
        return;
      }

      emit(PostLoading());

      try {
        await postRepository.createPost(
          nookId: event.nookId!,
          title: event.title,
          content: event.content,
          imagePaths: event.images,
        );

        emit(PostLoaded());
      } catch (e) {
        emit(PostLoadingFailure());
      }
    });

    on<UpdatePost>((event, emit) async {
      if (event.title.trim().isEmpty) {
        emit(PostTitleError());
        return;
      }

      if (postId == null) {
        emit(PostLoadingFailure());
        return;
      }

      emit(PostLoading());

      try {
        final List<String> imagesToAdd = event.images
            .where((image) => !image.startsWith('http'))
            .toList();

        final List<String> imagesToRemove = event.imagesToRemove
            .map((image) => image.split(baseUrl).last)
            .toList();

        await postRepository.updatePost(
          postId: postId!,
          title: event.title,
          content: event.content,
          imagesToAddPaths: imagesToAdd,
          imagesToRemoveUrls: imagesToRemove,
        );

        emit(PostLoaded());
      } catch (e) {
        emit(PostLoadingFailure());
      }
    });
  }

  final PostRepository postRepository;
  final String? postId;
  final String baseUrl;
}
