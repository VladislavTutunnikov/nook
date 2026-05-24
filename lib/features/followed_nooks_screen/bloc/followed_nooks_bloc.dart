import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nook/api/models/nook_model.dart';
import 'package:nook/api/repositories/user_repository.dart';

part 'followed_nooks_event.dart';
part 'followed_nooks_state.dart';

class FollowedNooksBloc extends Bloc<FollowedNooksEvent, FollowedNooksState> {
  FollowedNooksBloc({required this.userRepository, required this.userId})
    : super(FollowedNooksInitial()) {
    on<LoadFollowedNooks>((event, emit) async {
      if (event.isRefresh) {
        emit(FollowedNooksLoading());

        _cachedNooks.clear();
        _nooksOffset = 0;
        _hasMoreNooks = true;
        _isLoading = false;
      }

      if (_isLoading) return;

      if (event.offset > 0 && !_hasMoreNooks) return;

      _isLoading = true;

      try {
        final List<NookModel> followedNooks = await userRepository
            .getUserFollows(
              userId: userId,
              limit: event.limit,
              offset: event.offset,
            );

        _cachedNooks.addAll(followedNooks);
        _hasMoreNooks = followedNooks.length >= event.limit;
        _nooksOffset = event.offset + followedNooks.length;

        emit(
          FollowedNooksLoaded(
            followedNooks: _cachedNooks,
            hasMore: _hasMoreNooks,
            offset: _nooksOffset,
          ),
        );
      } catch (e) {
        if (_cachedNooks.isEmpty) {
          emit(FollowedNooksLoadingFailure(error: e.toString()));
        }
      } finally {
        _isLoading = false;
      }
    });
  }

  final UserRepository userRepository;
  final String? userId;

  bool _isLoading = false;

  final List<NookModel> _cachedNooks = [];
  int _nooksOffset = 0;
  bool _hasMoreNooks = true;
}
