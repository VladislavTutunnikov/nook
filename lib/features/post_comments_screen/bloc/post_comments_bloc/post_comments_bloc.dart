import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nook/api/models/comment_model.dart';
import 'package:nook/api/models/post_model.dart';
import 'package:nook/api/repositories/post_repository.dart';

part 'post_comments_event.dart';
part 'post_comments_state.dart';

class PostCommentsBloc extends Bloc<PostCommentsEvent, PostCommentsState> {
  PostCommentsBloc({required this.postRepository, required this.post})
    : super(PostCommentsInitial()) {
    on<LoadPostComments>((event, emit) async {
      //TODO: add pagination

      if (event.isRefresh) {
        emit(PostCommentsLoading());

        _cachedComments.clear();
        _commentsOffset = 0;
        _hasMoreComments = true;
        _isLoading = false;
      }

      if (_isLoading) return;

      if (event.offset > 0 && !_hasMoreComments) return;

      _isLoading = true;

      try {
        final List<CommentModel> comments = await postRepository
            .getPostComments(
              postId: post.id,
              limit: event.limit,
              offset: event.offset,
            );

        _cachedComments.addAll(comments);
        _hasMoreComments = comments.length >= event.limit;
        _commentsOffset = event.offset + comments.length;

        emit(
          PostCommentsLoaded(
            comments: _cachedComments,
            hasMore: _hasMoreComments,
            offset: _commentsOffset,
          ),
        );
      } catch (e) {
        emit(PostCommentsLoadingFailure(message: e.toString()));
      } finally {
        _isLoading = false;
      }
    });
  }

  final PostRepository postRepository;
  final PostModel post;

  bool _isLoading = false;

  final List<CommentModel> _cachedComments = [];
  int _commentsOffset = 0;
  bool _hasMoreComments = true;
}
