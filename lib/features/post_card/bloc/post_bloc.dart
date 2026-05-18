import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nook/api/models/nook_team_model.dart';
import 'package:nook/api/models/post_model.dart';
import 'package:nook/api/models/user_model.dart';
import 'package:nook/api/repositories/nook_repository.dart';
import 'package:nook/api/repositories/post_repository.dart';
import 'package:nook/api/repositories/user_repository.dart';
part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc({
    required this.postRepository,
    required this.userRepository,
    required this.nookRepository,
    required this.post,
  }) : super(PostInitial()) {
    on<SetupData>((event, emit) async {
      emit(
        PostUpdated(
          isLiked: _isLiked,
          isReposted: _isReposted,
          isSaved: _isSaved,
          isPinned: _isPinned,
          likeCount: _likeCount,
          repostCount: _repostCount,
          canDelete: _canDelete,
          canEdit: _canEdit,
          canPin: _canPin,
        ),
      );
      try {
        final UserModel user = await userRepository.getUser();
        final NookTeamModel nookTeam = await nookRepository.getNookTeam(
          nookId: post.nook.id,
        );

        if (user.id == post.user.id) {
          _canEdit = true;
          _canDelete = true;
        }

        if (user.id == nookTeam.owner?.id) {
          _canDelete = true;
          _canPin = true;
        }

        final List<String> moderatorsIds =
            nookTeam.moderators?.map((e) => e.id).toList() ?? [];

        if (moderatorsIds.contains(user.id)) {
          _canDelete = true;
        }

        emit(
          PostUpdated(
            isLiked: _isLiked,
            isReposted: _isReposted,
            isSaved: _isSaved,
            isPinned: _isPinned,
            likeCount: _likeCount,
            repostCount: _repostCount,
            canDelete: _canDelete,
            canEdit: _canEdit,
            canPin: _canPin,
          ),
        );
      } catch (e) {
        emit(
          PostUpdated(
            isLiked: _isLiked,
            isReposted: _isReposted,
            isSaved: _isSaved,
            isPinned: _isPinned,
            likeCount: _likeCount,
            repostCount: _repostCount,
            canDelete: _canDelete,
            canEdit: _canEdit,
            canPin: _canPin,
          ),
        );
      }
    });

    on<LikePost>((event, emit) async {
      if (_isProcessingLike) return;
      _isProcessingLike = true;

      final oldLikeCount = _likeCount;
      final oldIsLiked = _isLiked;

      try {
        if (_isLiked) {
          await postRepository.unlikePost(postId: _postId);
          _likeCount--;
        } else {
          await postRepository.likePost(postId: _postId);
          _likeCount++;
        }
        _isLiked = !_isLiked;

        emit(
          PostUpdated(
            isLiked: _isLiked,
            isReposted: _isReposted,
            isSaved: _isSaved,
            isPinned: _isPinned,
            likeCount: _likeCount,
            repostCount: _repostCount,
            canDelete: _canDelete,
            canEdit: _canEdit,
            canPin: _canPin,
          ),
        );
      } catch (e) {
        _likeCount = oldLikeCount;
        _isLiked = oldIsLiked;
        emit(
          PostUpdated(
            isLiked: _isLiked,
            isReposted: _isReposted,
            isSaved: _isSaved,
            isPinned: _isPinned,
            likeCount: _likeCount,
            repostCount: _repostCount,
            canDelete: _canDelete,
            canEdit: _canEdit,
            canPin: _canPin,
          ),
        );
      } finally {
        _isProcessingLike = false;
      }
    });

    on<RepostPost>((event, emit) async {
      if (_isProcessingRepost) return;
      _isProcessingRepost = true;

      final oldRepostCount = _repostCount;
      final oldIsReposted = _isReposted;

      try {
        if (_isReposted) {
          await postRepository.unrepostPost(postId: _postId);
          _repostCount--;
        } else {
          await postRepository.repostPost(postId: _postId);
          _repostCount++;
        }
        _isReposted = !_isReposted;

        emit(
          PostUpdated(
            isLiked: _isLiked,
            isReposted: _isReposted,
            isSaved: _isSaved,
            isPinned: _isPinned,
            likeCount: _likeCount,
            repostCount: _repostCount,
            canDelete: _canDelete,
            canEdit: _canEdit,
            canPin: _canPin,
          ),
        );
      } catch (e) {
        _repostCount = oldRepostCount;
        _isReposted = oldIsReposted;
        emit(
          PostUpdated(
            isLiked: _isLiked,
            isReposted: _isReposted,
            isSaved: _isSaved,
            isPinned: _isPinned,
            likeCount: _likeCount,
            repostCount: _repostCount,
            canDelete: _canDelete,
            canEdit: _canEdit,
            canPin: _canPin,
          ),
        );
      } finally {
        _isProcessingRepost = false;
      }
    });

    on<SavePost>((event, emit) async {
      if (_isProcessingSave) return;
      _isProcessingSave = true;

      final oldIsSaved = _isSaved;

      try {
        if (_isSaved) {
          await postRepository.unsavePost(postId: _postId);
        } else {
          await postRepository.savePost(postId: _postId);
        }
        _isSaved = !_isSaved;

        emit(
          PostUpdated(
            isLiked: _isLiked,
            isReposted: _isReposted,
            isSaved: _isSaved,
            isPinned: _isPinned,
            likeCount: _likeCount,
            repostCount: _repostCount,
            canDelete: _canDelete,
            canEdit: _canEdit,
            canPin: _canPin,
          ),
        );
      } catch (e) {
        _isSaved = oldIsSaved;
        emit(
          PostUpdated(
            isLiked: _isLiked,
            isReposted: _isReposted,
            isSaved: _isSaved,
            isPinned: _isPinned,
            likeCount: _likeCount,
            repostCount: _repostCount,
            canDelete: _canDelete,
            canEdit: _canEdit,
            canPin: _canPin,
          ),
        );
      } finally {
        _isProcessingSave = false;
      }
    });

    on<PinPost>((event, emit) async {
      if (_isProcessingPin) return;
      _isProcessingPin = true;

      final oldIsPinned = _isPinned;

      try {
        if (_isPinned) {
          await postRepository.unpinPost(postId: _postId);
        } else {
          await postRepository.pinPost(postId: _postId);
        }
        _isPinned = !_isPinned;

        emit(
          PostUpdated(
            isLiked: _isLiked,
            isReposted: _isReposted,
            isSaved: _isSaved,
            isPinned: _isPinned,
            likeCount: _likeCount,
            repostCount: _repostCount,
            canDelete: _canDelete,
            canEdit: _canEdit,
            canPin: _canPin,
          ),
        );
      } catch (e) {
        _isPinned = oldIsPinned;
        emit(
          PostUpdated(
            isLiked: _isLiked,
            isReposted: _isReposted,
            isSaved: _isSaved,
            isPinned: _isPinned,
            likeCount: _likeCount,
            repostCount: _repostCount,
            canDelete: _canDelete,
            canEdit: _canEdit,
            canPin: _canPin,
          ),
        );
      } finally {
        _isProcessingPin = false;
      }
    });

    on<DeletePost>((event, emit) async {
      try {
        await postRepository.deletePost(postId: _postId);
        emit(PostDeleted());
      } catch (e) {
        emit(
          PostUpdated(
            isLiked: _isLiked,
            isReposted: _isReposted,
            isSaved: _isSaved,
            isPinned: _isPinned,
            likeCount: _likeCount,
            repostCount: _repostCount,
            canDelete: _canDelete,
            canEdit: _canEdit,
            canPin: _canPin,
          ),
        );
      }
    });
  }

  final PostModel post;

  late final String _postId = post.id;
  late int _likeCount = post.likeCount;
  late int _repostCount = post.repostCount;
  late bool _isLiked = post.isLiked;
  late bool _isReposted = post.isReposted;
  late bool _isSaved = post.isSaved;
  late bool _isPinned = post.isPinned;

  bool _isProcessingLike = false;
  bool _isProcessingRepost = false;
  bool _isProcessingSave = false;
  bool _isProcessingPin = false;

  bool _canDelete = false;
  bool _canEdit = false;
  bool _canPin = false;

  final PostRepository postRepository;
  final UserRepository userRepository;
  final NookRepository nookRepository;
}
