import 'package:dio/dio.dart';
import 'package:nook/api/models/comment_model.dart';
import 'package:nook/api/models/post_model.dart';
import 'package:nook/api/nook_api.dart';

class PostRepository {
  PostRepository({required this.apiClient});

  final NookApiClient apiClient;

  Future<PostModel> getPost({required String postId}) async {
    try {
      final PostModel response = await apiClient.getPost(postId: postId);

      return response;
    } on DioException catch (e) {
      throw Exception('Post upload error: ${e.message}');
    }
  }

  Future<void> createPost({
    required String nookId,
    required String title,
    String? content,
    List<String>? imagePaths,
  }) async {
    try {
      List<MultipartFile>? images;
      if (imagePaths != null && imagePaths.isNotEmpty) {
        images = await Future.wait(
          imagePaths.map((path) => MultipartFile.fromFile(path)),
        );
      }

      await apiClient.createPost(
        nookId: nookId,
        title: title,
        content: content,
        images: images,
      );
    } on DioException catch (e) {
      throw Exception('Post create error: ${e.message}');
    }
  }

  Future<void> updatePost({
    required String postId,
    required String title,
    String? content,
    List<String>? imagesToAddPaths,
    List<String>? imagesToRemoveUrls,
  }) async {
    try {
      List<MultipartFile>? imagesToAdd;
      if (imagesToAddPaths != null && imagesToAddPaths.isNotEmpty) {
        imagesToAdd = await Future.wait(
          imagesToAddPaths.map((path) => MultipartFile.fromFile(path)),
        );
      }

      await apiClient.updatePost(
        postId: postId,
        title: title,
        content: content,
        imagesToAdd: imagesToAdd,
        imagesToRemove: imagesToRemoveUrls,
      );
    } on DioException catch (e) {
      throw Exception('Post update error: ${e.message}');
    }
  }

  Future<void> deletePost({required String postId}) async {
    try {
      await apiClient.deletePost(postId: postId);
    } on DioException catch (e) {
      throw Exception('Post delete error: ${e.message}');
    }
  }

  Future<void> likePost({required String postId}) async {
    try {
      await apiClient.likePost(postId: postId);
    } on DioException catch (e) {
      throw Exception('Post like error: ${e.message}');
    }
  }

  Future<void> unlikePost({required String postId}) async {
    try {
      await apiClient.unlikePost(postId: postId);
    } on DioException catch (e) {
      throw Exception('Post unlike error: ${e.message}');
    }
  }

  Future<void> repostPost({required String postId}) async {
    try {
      await apiClient.repostPost(postId: postId);
    } on DioException catch (e) {
      throw Exception('Post repost error: ${e.message}');
    }
  }

  Future<void> unrepostPost({required String postId}) async {
    try {
      await apiClient.unrepostPost(postId: postId);
    } on DioException catch (e) {
      throw Exception('Post unrepost error: ${e.message}');
    }
  }

  Future<void> savePost({required String postId}) async {
    try {
      await apiClient.savePost(postId: postId);
    } on DioException catch (e) {
      throw Exception('Post save error: ${e.message}');
    }
  }

  Future<void> unsavePost({required String postId}) async {
    try {
      await apiClient.unsavePost(postId: postId);
    } on DioException catch (e) {
      throw Exception('Post unsave error: ${e.message}');
    }
  }

  Future<void> pinPost({required String postId}) async {
    try {
      await apiClient.pinPost(postId: postId);
    } on DioException catch (e) {
      throw Exception('Post pin error: ${e.message}');
    }
  }

  Future<void> unpinPost({required String postId}) async {
    try {
      await apiClient.unpinPost(postId: postId);
    } on DioException catch (e) {
      throw Exception('Post unpin error: ${e.message}');
    }
  }

  Future<List<PostModel>> getFeed({int limit = 20, int offset = 0}) async {
    try {
      final response = await apiClient.getFeed(limit: limit, offset: offset);
      return response;
    } on DioException catch (e) {
      throw Exception('Feed upload error: ${e.message}');
    }
  }

  Future<List<CommentModel>> getPostComments({
    required String postId,
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final response = await apiClient.getPostComments(
        postId: postId,
        limit: limit,
        offset: offset,
      );
      return response;
    } on DioException catch (e) {
      throw Exception('Post comments upload error: ${e.message}');
    }
  }

  Future<void> createComment({
    required String postId,
    required String content,
  }) async {
    try {
      await apiClient.createComment(postId: postId, content: content);
    } on DioException catch (e) {
      throw Exception('Create comment error: ${e.message}');
    }
  }
}
