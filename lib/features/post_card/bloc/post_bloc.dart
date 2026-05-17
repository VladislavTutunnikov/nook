import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nook/api/models/post_model.dart';
import 'package:nook/api/repositories/post_repository.dart';
part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc({required this.postRepository, required this.post})
    : super(PostInitial()) {

    on<SetupData>((event, emit) async {
      emit(
          PostUpdated(
            isLiked: _isLiked,
            isReposted: _isReposted,
            isSaved: _isSaved,
            likeCount: _likeCount,
            repostCount: _repostCount,
          ),
        );
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
            likeCount: _likeCount,
            repostCount: _repostCount,
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
            likeCount: _likeCount,
            repostCount: _repostCount,
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
            likeCount: _likeCount,
            repostCount: _repostCount,
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
            likeCount: _likeCount,
            repostCount: _repostCount,
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
            likeCount: _likeCount,
            repostCount: _repostCount,
          ),
        );
      } catch (e) {
        _isSaved = oldIsSaved;
        emit(
          PostUpdated(
            isLiked: _isLiked,
            isReposted: _isReposted,
            isSaved: _isSaved,
            likeCount: _likeCount,
            repostCount: _repostCount,
          ),
        );
      } finally {
        _isProcessingSave = false;
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

  bool _isProcessingLike = false;
  bool _isProcessingRepost = false;
  bool _isProcessingSave = false;

  final PostRepository postRepository;
}
