import 'package:dio/dio.dart';
import 'package:nook/api/models/login_request_model.dart';
import 'package:nook/api/models/refresh_request_model.dart';
import 'package:nook/api/models/register_request_model.dart';
import 'package:nook/api/nook_api.dart';
import 'package:nook/api/repositories/user_repository.dart';
import 'package:nook/core/storage/secure_storage.dart';

class AuthRepository {
  AuthRepository({required this.apiClient, required this.secureStorage});

  final NookApiClient apiClient;
  final SecureStorage secureStorage;

  Future<void> login(String login, String password) async {
    try {
      final request = LoginRequestModel(login: login, password: password);
      final response = await apiClient.login(request);
      await secureStorage.saveTokens(
        response.accessToken,
        response.refreshToken,
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw InvalidLoginOrPasswordException('Invalid login or password');
      } else if (e.response?.statusCode == 403) {
        throw AccountBannedException('Account has been banned');
      }
      throw Exception(e);
    }
  }

  Future<void> refresh() async {
    try {
      final refreshToken = await secureStorage.getRefreshToken();
      if (refreshToken == null || refreshToken.isEmpty) {
        throw Exception('Refresh token not found');
      }
      final request = RefreshRequestModel(refreshToken: refreshToken);
      final response = await apiClient.refresh(request);

      await secureStorage.updateAccessToken(response.accessToken);
    } on DioException catch (e) {
      await secureStorage.clearTokens();
      throw Exception(e);
    }
  }

  Future<void> register({
    required String email,
    required String username,
    required String password,
  }) async {
    try {
      final request = RegisterRequestModel(
        email: email,
        username: username,
        password: password,
      );
      final response = await apiClient.register(request);
      await secureStorage.saveTokens(
        response.accessToken,
        response.refreshToken,
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        final detail = e.response?.data?['detail'] ?? '';

        if (detail.contains('Email')) {
          throw EmailTakenException(detail);
        } else if (detail.contains('Username')) {
          throw UsernameTakenException(detail);
        }
      }
      throw Exception(e);
    }
  }

  Future<void> logout() async {
    try {
      final refreshToken = await secureStorage.getRefreshToken();
      if (refreshToken != null && refreshToken.isNotEmpty) {
        final request = RefreshRequestModel(refreshToken: refreshToken);
        await apiClient.logout(request);
      }
    } finally {
      await secureStorage.clearTokens();
    }
  }

  Future<String?> getAccessToken() async {
    return await secureStorage.getAccessToken();
  }

  Future<String?> getRefreshToken() async {
    return await secureStorage.getRefreshToken();
  }

  Future<bool> isAuthenticated() async {
    return await secureStorage.hasTokens();
  }
}

class InvalidLoginOrPasswordException implements Exception {
  InvalidLoginOrPasswordException(this.message);
  final String message;
}

class AccountBannedException implements Exception {
  AccountBannedException(this.message);
  final String message;
}

class EmailTakenException implements Exception {
  final String message;
  EmailTakenException(this.message);
}
