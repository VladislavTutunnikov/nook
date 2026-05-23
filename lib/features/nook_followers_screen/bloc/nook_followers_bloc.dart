import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nook/api/models/nook_member_model.dart';
import 'package:nook/api/repositories/nook_repository.dart';

part 'nook_followers_event.dart';
part 'nook_followers_state.dart';

class NookFollowersBloc extends Bloc<NookFollowersEvent, NookFollowersState> {
  NookFollowersBloc({
    required this.nookRepository,
    required this.nookId,
    required this.showBanned,
  }) : super(NookFollowersInitial()) {
    on<LoadFollowers>((event, emit) async {
      if (event.isRefresh) {
        emit(NookFollowersLoading());

        _cachedFollowers.clear();
        _followersOffset = 0;
        _hasMoreFollowers = true;
        _isLoading = false;
      }

      if (_isLoading) return;

      if (event.offset > 0 && !_hasMoreFollowers) return;

      _isLoading = true;

      try {
        final List<NookMemberModel> followers;
        if (showBanned) {
          followers = await nookRepository.getNookBannedFollowers(
            nookId: nookId,
            limit: event.limit,
            offset: event.offset,
          );
        } else {
          followers = await nookRepository.getNookFollowers(
            nookId: nookId,
            limit: event.limit,
            offset: event.offset,
          );
        }

        _cachedFollowers.addAll(followers);
        _hasMoreFollowers = followers.length >= event.limit;
        _followersOffset = event.offset + followers.length;

        emit(
          NookFollowersLoaded(
            followers: _cachedFollowers,
            hasMore: _hasMoreFollowers,
            offset: _followersOffset,
          ),
        );
      } catch (e) {
        if (_cachedFollowers.isEmpty) {
          emit(NookFollowersLoadingFailure(error: e.toString()));
        }
      } finally {
        _isLoading = false;
      }
    });
  }

  final NookRepository nookRepository;
  final String nookId;
  final bool showBanned;

  bool _isLoading = false;

  final List<NookMemberModel> _cachedFollowers = [];
  int _followersOffset = 0;
  bool _hasMoreFollowers = true;
}
