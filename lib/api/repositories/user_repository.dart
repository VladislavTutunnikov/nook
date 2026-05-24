import 'package:dio/dio.dart';
import 'package:nook/api/models/comment_model.dart';
import 'package:nook/api/models/nook_model.dart';
import 'package:nook/api/models/post_model.dart';
import 'package:nook/api/models/user_model.dart';
import 'package:nook/api/nook_api.dart';

class UserRepository {
  UserRepository({required this.apiClient});

  final NookApiClient apiClient;

  Future<UserModel> getUser({String? userId}) async {
    try {
      final UserModel response;
      if (userId == null) {
        response = await apiClient.getMe();
      } else {
        response = await apiClient.getUser(userId: userId);
      }
      return response;
    } on DioException catch (e) {
      throw Exception('User upload error: ${e.message}');
    }
  }

  Future<List<String>> getUserFollowedAvatars({
    String? userId,
    int limit = 3,
  }) async {
    try {
      final List<NookModel> response;
      if (userId == null) {
        response = await apiClient.getMyFollows(limit: limit, offset: 0);
      } else {
        response = await apiClient.getUserFollows(
          userId: userId,
          limit: limit,
          offset: 0,
        );
      }

      final List<String> avatarUrls = [];

      for (NookModel nook in response) {
        avatarUrls.add(nook.avatarUrl ?? '');
      }

      return avatarUrls;
    } on DioException catch (e) {
      throw Exception('Following list upload error: ${e.message}');
    }
  }

  Future<List<PostModel>> getUserPosts({
    String? userId,
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final List<PostModel> response;
      if (userId == null) {
        response = await apiClient.getMyPosts(limit: limit, offset: offset);
      } else {
        response = await apiClient.getUserPosts(
          userId: userId,
          limit: limit,
          offset: offset,
        );
      }
      return response;
    } on DioException catch (e) {
      throw Exception('Post list upload error: ${e.message}');
    }
  }

  Future<List<CommentModel>> getUserComments({
    String? userId,
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final List<CommentModel> response;
      if (userId == null) {
        response = await apiClient.getMyComments(limit: limit, offset: offset);
      } else {
        response = await apiClient.getUserComments(
          userId: userId,
          limit: limit,
          offset: offset,
        );
      }

      return response;
    } on DioException catch (e) {
      throw Exception('Comment list upload error: ${e.message}');
    }
  }

  Future<List<PostModel>> getUserReposts({
    String? userId,
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final List<PostModel> response;
      if (userId == null) {
        response = await apiClient.getMyReposts(limit: limit, offset: offset);
      } else {
        response = await apiClient.getUserReposts(
          userId: userId,
          limit: limit,
          offset: offset,
        );
      }

      return response;
    } on DioException catch (e) {
      throw Exception('Post list upload error: ${e.message}');
    }
  }

  Future<List<PostModel>> getUserLikes({
    String? userId,
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final List<PostModel> response;
      if (userId == null) {
        response = await apiClient.getMyLikes(limit: limit, offset: offset);
      } else {
        response = await apiClient.getUserLikes(
          userId: userId,
          limit: limit,
          offset: offset,
        );
      }
      return response;
    } on DioException catch (e) {
      throw Exception('Post list upload error: ${e.message}');
    }
  }

  Future<List<PostModel>> getMySavedPosts({
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final List<PostModel> response = await apiClient.getMySavedPosts(
        limit: limit,
        offset: offset,
      );
      return response;
    } on DioException catch (e) {
      throw Exception('Saved post list upload error: ${e.message}');
    }
  }

  Future<List<NookModel>> getUserFollows({
    String? userId,
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final List<NookModel> response;
      if (userId == null) {
        response = await apiClient.getMyFollows(limit: limit, offset: offset);
      } else {
        response = await apiClient.getUserFollows(
          userId: userId,
          limit: limit,
          offset: offset,
        );
      }

      return response;
    } on DioException catch (e) {
      throw Exception('Follows list upload error: ${e.message}');
    }
  }
}
