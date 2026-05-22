import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nook/api/models/post_model.dart';
import 'package:nook/api/repositories/nook_repository.dart';
part 'nook_pinned_event.dart';
part 'nook_pinned_state.dart';

class NookPinnedBloc extends Bloc<NookPinnedEvent, NookPinnedState> {
  NookPinnedBloc({required this.nookRepository, required this.nookId})
    : super(NookPinnedInitial()) {
    on<LoadNookPinnedPosts>((event, emit) async {
      if (event.isRefresh) {
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
        final posts = await nookRepository.getNookPinnedPosts(
          nookId: nookId,
          limit: event.limit,
          offset: event.offset,
        );
        print(
          '🐦‍🔥🐦‍🔥🐦‍🔥🐦‍🔥🐦‍🔥🐦‍🔥🐦‍🔥🐦‍🔥🐦‍🔥🐦‍🔥 ПОДГРУЗИЛИ ПОСТЫ ОФСЕТ ${event.offset}',
        );
        _cachedPosts.addAll(posts);
        _hasMorePosts = posts.length >= event.limit;
        _postsOffset = event.offset + posts.length;

        print('🔁🔁🔁🔁🔁🔁🔁🔁🔁🔁 КОЛВО ПИНОВ ${_cachedPosts.length}');

        emit(
          NookPinnedPostsLoaded(
            posts: _cachedPosts,
            hasMore: _hasMorePosts,
            offset: _postsOffset,
          ),
        );
      } catch (e) {
        if (_cachedPosts.isEmpty) {
          emit(NookPinnedPostsLoadingFailure(error: e.toString()));
        }
      } finally {
        _isLoading = false;
      }
    });
  }

  final NookRepository nookRepository;
  final String nookId;

  bool _isLoading = false;

  final List<PostModel> _cachedPosts = [];
  int _postsOffset = 0;
  bool _hasMorePosts = true;
}
