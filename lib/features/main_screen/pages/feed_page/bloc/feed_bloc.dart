import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nook/api/models/post_model.dart';
import 'package:nook/api/repositories/post_repository.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  FeedBloc({required this.postRepository}) : super(FeedInitial()) {
    on<LoadFeed>((event, emit) async {
      if (event.isRefresh) {
        emit(FeedLoading());
        _cachedPosts.clear();
        _postsOffset = 0;
        _hasMorePosts = true;
        _isLoading = false;
      }

      if (_isLoading) return;

      if (event.offset > 0 && !_hasMorePosts) {
        return;
      }

      _isLoading = true;

      try {
        final posts = await postRepository.getFeed(
          limit: event.limit,
          offset: event.offset,
        );
        _cachedPosts.addAll(posts);
        _hasMorePosts = posts.length >= event.limit;
        _postsOffset = event.offset + posts.length;

        emit(
          FeedLoaded(
            posts: _cachedPosts,
            hasMore: _hasMorePosts,
            offset: _postsOffset,
          ),
        );
      } catch (e) {
        if (_cachedPosts.isEmpty) {
          emit(FeedLoadingFailure(error: e.toString()));
        }
      } finally {
        _isLoading = false;
      }
    });
  }

  final PostRepository postRepository;

  bool _isLoading = false;

  final List<PostModel> _cachedPosts = [];
  int _postsOffset = 0;
  bool _hasMorePosts = true;
}
