import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nook/api/repositories/post_repository.dart';

part 'create_comment_event.dart';
part 'create_comment_state.dart';

class CreateCommentBloc extends Bloc<CreateCommentEvent, CreateCommentState> {
  CreateCommentBloc({required this.postRepository, required this.postId})
    : super(CreateCommentInitial()) {
    on<CreateComment>((event, emit) async {
      if (event.content.trim().isEmpty) {
        return;
      }

      emit(CreateCommentLoading());

      try {
        await postRepository.createComment(
          postId: postId,
          content: event.content,
        );
        emit(CreateCommentLoaded());
      } catch (e) {
        emit(CreateCommentLoadingFailure(message: e.toString()));
      }
    });
  }

  final PostRepository postRepository;
  final String postId;
}
