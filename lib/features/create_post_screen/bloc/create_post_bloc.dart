import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nook/api/repositories/post_repository.dart';

part 'create_post_event.dart';
part 'create_post_state.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  CreatePostBloc({required this.postRepository}) : super(CreatePostInitial()) {
    on<SendPost>((event, emit) async {
      if (event.title.trim().isEmpty) {
        emit(CreatePostTitleError());
        return;
      }
      if (event.nookId == null || event.nookId!.trim().isEmpty) {
        emit(CreatePostNookIdError());
        return;
      }

      try {
        emit(CreatePostLoading());

        final List<String> imagePaths = event.images
            .map((image) => image.path)
            .toList();

        await postRepository.createPost(
          nookId: event.nookId!,
          title: event.title,
          content: event.content,
          imagePaths: imagePaths,
        );

        emit(PostCreated());
      } catch (e) {
        emit(CreatePostFailure());
      }
    });
  }

  final PostRepository postRepository;
}
