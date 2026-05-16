import 'package:dio/dio.dart';
import 'package:nook/api/models/comment_model.dart';
import 'package:nook/api/models/nook_model.dart';
import 'package:nook/api/models/post_model.dart';
import 'package:nook/api/models/user_model.dart';
import 'package:nook/api/nook_api.dart';

class PostRepository {
  PostRepository({required this.apiClient});

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

  
}
