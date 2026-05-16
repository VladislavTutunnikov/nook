import 'package:dio/dio.dart';
import 'package:nook/api/models/comment_model.dart';
import 'package:nook/api/models/nook_model.dart';
import 'package:nook/api/models/post_model.dart';
import 'package:nook/api/models/user_model.dart';
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

  Future<void> deletePost({required String postId}) async {
    try {
      await apiClient.deletePost(postId: postId);
    } on DioException catch (e) {
      throw Exception('Post delete error: ${e.message}');
    }
  }
}
