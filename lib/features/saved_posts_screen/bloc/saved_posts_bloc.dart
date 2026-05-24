import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nook/api/models/post_model.dart';
import 'package:nook/api/repositories/user_repository.dart';

part 'saved_posts_event.dart';
part 'saved_posts_state.dart';

class SavedPostsBloc extends Bloc<SavedPostsEvent, SavedPostsState> {
  SavedPostsBloc({required this.userRepository}) : super(SavedPostsInitial()) {
    on<LoadSavedPosts>((event, emit) async {
      if (event.isRefresh) {
        emit(SavedPostsLoading());

        _cachedPosts.clear();
        _postsOffset = 0;
        _hasMorePosts = true;
        _isLoading = false;
      }

      if (_isLoading) return;

      if (event.offset > 0 && !_hasMorePosts) return;

      _isLoading = true;

      try {
        final List<PostModel> savedPosts = await userRepository.getMySavedPosts(
          limit: event.limit,
          offset: event.offset,
        );

        _cachedPosts.addAll(savedPosts);
        _hasMorePosts = savedPosts.length >= event.limit;
        _postsOffset = event.offset + savedPosts.length;

        emit(
          SavedPostsLoaded(
            savedPosts: _cachedPosts,
            hasMore: _hasMorePosts,
            offset: _postsOffset,
          ),
        );
      } catch (e) {
        if (_cachedPosts.isEmpty) {
          emit(SavedPostsLoadingFailure(error: e.toString()));
        }
      } finally {
        _isLoading = false;
      }
    });
  }

  final UserRepository userRepository;

  bool _isLoading = false;

  final List<PostModel> _cachedPosts = [];
  int _postsOffset = 0;
  bool _hasMorePosts = true;
}
