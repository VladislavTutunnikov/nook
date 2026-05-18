import 'package:dio/dio.dart';
import 'package:nook/api/models/comment_model.dart';
import 'package:nook/api/models/nook_model.dart';
import 'package:nook/api/models/nook_team_model.dart';
import 'package:nook/api/models/post_model.dart';
import 'package:nook/api/models/user_model.dart';
import 'package:nook/api/nook_api.dart';

class NookRepository {
  NookRepository({required this.apiClient});

  final NookApiClient apiClient;

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
