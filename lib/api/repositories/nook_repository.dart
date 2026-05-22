import 'package:dio/dio.dart';
import 'package:nook/api/models/comment_model.dart';
import 'package:nook/api/models/nook_member_model.dart';
import 'package:nook/api/models/nook_model.dart';
import 'package:nook/api/models/nook_team_model.dart';
import 'package:nook/api/models/post_model.dart';
import 'package:nook/api/models/user_model.dart';
import 'package:nook/api/nook_api.dart';

enum PostFilter { byPopularity, byNovelty }

class NookRepository {
  NookRepository({required this.apiClient});

  final NookApiClient apiClient;

  Future<NookModel> getNook({required String nookId}) async {
    try {
      final NookModel response = await apiClient.getNook(nookId: nookId);
      return response;
    } on DioException catch (e) {
      throw Exception('Nook upload error: ${e.message}');
    }
  }

  Future<List<PostModel>> getNookPosts({
    required String nookId,
    PostFilter? filter,
    String? prompt,
    int limit = 20,
    int offset = 0,
  }) async {
    String? postFilter;
    if (filter != null) {
      if (filter == PostFilter.byPopularity) {
        postFilter = 'popular';
      } else {
        postFilter = 'new';
      }
    }
    try {
      final List<PostModel> response = await apiClient.getNookPosts(
        nookId: nookId,
        filter: postFilter,
        prompt: prompt,
        limit: limit,
        offset: offset,
      );
      return response;
    } on DioException catch (e) {
      throw Exception('Nook posts upload error: ${e.message}');
    }
  }

  Future<List<PostModel>> getNookPinnedPosts({
    required String nookId,
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final List<PostModel> response = await apiClient.getNookPinnedPosts(
        nookId: nookId,
        limit: limit,
        offset: offset,
      );
      return response;
    } on DioException catch (e) {
      throw Exception('Nook pinned posts upload error: ${e.message}');
    }
  }

  Future<void> followNook({required String nookId}) async {
    try {
      await apiClient.followNook(nookId: nookId);
    } on DioException catch (e) {
      throw Exception('Follow nook error: ${e.message}');
    }
  }

  Future<void> unfollowNook({required String nookId}) async {
    try {
      await apiClient.unfollowNook(nookId: nookId);
    } on DioException catch (e) {
      throw Exception('Unfollow nook error: ${e.message}');
    }
  }

  Future<List<NookMemberModel>> getNookFollowers({
    required String nookId,
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final List<NookMemberModel> response = await apiClient.getNookFollowers(
        nookId: nookId,
        limit: limit,
        offset: offset,
      );
      return response;
    } on DioException catch (e) {
      throw Exception('Nook followers upload error: ${e.message}');
    }
  }

  Future<NookTeamModel> getNookTeam({required String nookId}) async {
    try {
      final NookTeamModel response = await apiClient.getNookTeam(
        nookId: nookId,
      );
      return response;
    } on DioException catch (e) {
      throw Exception('Nook team upload error: ${e.message}');
    }
  }
}
