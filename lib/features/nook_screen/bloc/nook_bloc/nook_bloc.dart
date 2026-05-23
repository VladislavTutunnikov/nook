import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nook/api/models/nook_model.dart';
import 'package:nook/api/models/nook_team_model.dart';
import 'package:nook/api/models/user_model.dart';
import 'package:nook/api/repositories/nook_repository.dart';
import 'package:nook/api/repositories/user_repository.dart';

part 'nook_event.dart';
part 'nook_state.dart';

class NookBloc extends Bloc<NookEvent, NookState> {
  NookBloc({
    required this.nookRepository,
    required this.userRepository,
    required this.nookId,
  }) : super(NookInitial()) {
    on<LoadNookData>((event, emit) async {
      emit(NookLoading());

      try {
        final NookModel nook = await nookRepository.getNook(nookId: nookId);
        final NookTeamModel team = await nookRepository.getNookTeam(
          nookId: nookId,
        );
        final UserModel currentUser = await userRepository.getUser();

        final List<String>? moderatorsList = team.moderators
            ?.map((e) => e.id)
            .toList();
        _isOwner = nook.ownerId == currentUser.id;

        if (moderatorsList != null && moderatorsList.isNotEmpty) {
          _isModerator = moderatorsList.contains(currentUser.id);
        }
        _nook = nook;
        _isFollowed = nook.isFollowed;
        _followersCount = nook.followersCount;

        emit(
          NookLoaded(
            nook: nook,
            isFollowed: _isFollowed,
            followersCount: _followersCount,
            isOwner: _isOwner,
            isModerator: _isModerator,
          ),
        );
      } catch (e) {
        emit(NookLoadingFailure(error: e.toString()));
      }
    });

    on<FollowNook>((event, emit) async {
      if (state is! NookLoaded) return;

      if (_isOwner) return;

      if (_isProcessingFollow) return;
      _isProcessingFollow = true;

      final oldIsFollowed = _isFollowed;
      final oldFollowersCount = _followersCount;

      try {
        if (_isFollowed) {
          await nookRepository.unfollowNook(nookId: nookId);
          _followersCount--;
        } else {
          await nookRepository.followNook(nookId: nookId);
          _followersCount++;
        }
        _isFollowed = !_isFollowed;

        emit(
          NookLoaded(
            nook: _nook,
            isFollowed: _isFollowed,
            followersCount: _followersCount,
            isOwner: _isOwner,
            isModerator: _isModerator,
          ),
        );
      } catch (e) {
        _isFollowed = oldIsFollowed;
        _followersCount = oldFollowersCount;
        emit(
          NookLoaded(
            nook: _nook,
            isFollowed: _isFollowed,
            followersCount: _followersCount,
            isOwner: _isOwner,
            isModerator: _isModerator,
          ),
        );
      } finally {
        _isProcessingFollow = false;
      }
    });
  }

  final NookRepository nookRepository;
  final UserRepository userRepository;
  final String nookId;

  late NookModel _nook;
  bool _isFollowed = false;
  int _followersCount = 0;
  bool _isOwner = false;
  bool _isModerator = false;
  bool _isProcessingFollow = false;
}
