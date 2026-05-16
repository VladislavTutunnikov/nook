import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nook/api/models/comment_model.dart';
import 'package:nook/api/models/post_model.dart';
import 'package:nook/api/repositories/user_repository.dart';
part 'content_event.dart';
part 'content_state.dart';

class ContentBloc extends Bloc<ContentEvent, ContentState> {
  ContentBloc({required this.userRepository, this.userId})
    : super(ContentInitial()) {
    on<LoadPosts>((event, emit) async {
      if (event.isRefresh) {
        _cachedPosts.clear();
        _postsOffset = 0;
        _hasMorePosts = true;
        _isLoading = false;
      }

      if (_isLoading) return;

      if (_cachedPosts.isNotEmpty && !event.isRefresh && event.offset == 0) {
        emit(
          PostsLoaded(
            posts: _cachedPosts,
            hasMore: _hasMorePosts,
            offset: _postsOffset,
          ),
        );
        return;
      }

      if (event.offset > 0 && !_hasMorePosts) {
        return;
      }

      _isLoading = true;

      try {
        final posts = await userRepository.getUserPosts(
          userId: userId,
          limit: event.limit,
          offset: event.offset,
        );
        _cachedPosts.addAll(posts);
        _hasMorePosts = posts.length >= event.limit;
        _postsOffset = event.offset + posts.length;

        emit(
          PostsLoaded(
            posts: _cachedPosts,
            hasMore: _hasMorePosts,
            offset: _postsOffset,
          ),
        );
      } catch (e) {
        if (_cachedPosts.isEmpty) {
          emit(ContentLoadFailure(error: e.toString()));
        }
      } finally {
        _isLoading = false;
      }
    });

    on<LoadComments>((event, emit) async {
      if (event.isRefresh) {
        _cachedComments.clear();
        _commentsOffset = 0;
        _hasMoreComments = true;
        _isLoading = false;
      }

      if (_isLoading) return;

      if (_cachedComments.isNotEmpty && !event.isRefresh && event.offset == 0) {
        emit(
          CommentsLoaded(
            comments: _cachedComments,
            hasMore: _hasMoreComments,
            offset: _commentsOffset,
          ),
        );
        return;
      }

      if (event.offset > 0 && !_hasMoreComments) {
        return;
      }

      _isLoading = true;

      try {
        final comments = await userRepository.getUserComments(
          userId: userId,
          limit: event.limit,
          offset: event.offset,
        );

        _cachedComments.addAll(comments);
        _hasMoreComments = comments.length >= event.limit;
        _commentsOffset = event.offset + comments.length;

        emit(
          CommentsLoaded(
            comments: _cachedComments,
            hasMore: _hasMoreComments,
            offset: _commentsOffset,
          ),
        );
      } catch (e) {
        if (_cachedComments.isEmpty) {
          emit(ContentLoadFailure(error: e.toString()));
        }
      } finally {
        _isLoading = false;
      }
    });

    on<LoadReposts>((event, emit) async {
      if (event.isRefresh) {
        _cachedReposts.clear();
        _repostsOffset = 0;
        _hasMoreReposts = true;
        _isLoading = false;
      }

      if (_isLoading) return;

      if (_cachedReposts.isNotEmpty && !event.isRefresh && event.offset == 0) {
        emit(
          PostsLoaded(
            posts: _cachedReposts,
            hasMore: _hasMoreReposts,
            offset: _repostsOffset,
          ),
        );
        return;
      }

      if (event.offset > 0 && !_hasMoreReposts) {
        return;
      }

      _isLoading = true;

      try {
        final reposts = await userRepository.getUserReposts(
          userId: userId,
          limit: event.limit,
          offset: event.offset,
        );

        _cachedReposts.addAll(reposts);
        _hasMoreReposts = reposts.length >= event.limit;
        _repostsOffset = event.offset + reposts.length;

        emit(
          PostsLoaded(
            posts: _cachedReposts,
            hasMore: _hasMoreReposts,
            offset: _repostsOffset,
          ),
        );
      } catch (e) {
        if (_cachedReposts.isEmpty) {
          emit(ContentLoadFailure(error: e.toString()));
        }
      } finally {
        _isLoading = false;
      }
    });

    on<LoadLikes>((event, emit) async {
      if (event.isRefresh) {
        _cachedLikes.clear();
        _likesOffset = 0;
        _hasMoreLikes = true;
        _isLoading = false;
      }

      if (_isLoading) return;

      if (_cachedLikes.isNotEmpty && !event.isRefresh && event.offset == 0) {
        emit(
          PostsLoaded(
            posts: _cachedLikes,
            hasMore: _hasMoreLikes,
            offset: _likesOffset,
          ),
        );
        return;
      }

      if (event.offset > 0 && !_hasMoreLikes) {
        return;
      }

      _isLoading = true;

      try {
        final likes = await userRepository.getUserLikes(
          userId: userId,
          limit: event.limit,
          offset: event.offset,
        );
        print('Первый пост isLiked: ${likes.first.isLiked}');
        _cachedLikes.addAll(likes);
        _hasMoreLikes = likes.length >= event.limit;
        _likesOffset = event.offset + likes.length;
        emit(
          PostsLoaded(
            posts: _cachedLikes,
            hasMore: _hasMoreLikes,
            offset: _likesOffset,
          ),
        );
      } catch (e) {
        if (_cachedLikes.isEmpty) {
          emit(ContentLoadFailure(error: e.toString()));
        }
      } finally {
        _isLoading = false;
      }
    });
  }
  final String? userId;
  final UserRepository userRepository;

  bool _isLoading = false;

  final List<PostModel> _cachedPosts = [];
  int _postsOffset = 0;
  bool _hasMorePosts = true;

  final List<CommentModel> _cachedComments = [];
  int _commentsOffset = 0;
  bool _hasMoreComments = true;

  final List<PostModel> _cachedReposts = [];
  int _repostsOffset = 0;
  bool _hasMoreReposts = true;

  final List<PostModel> _cachedLikes = [];
  int _likesOffset = 0;
  bool _hasMoreLikes = true;
}
