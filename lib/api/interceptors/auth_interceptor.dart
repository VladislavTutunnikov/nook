import 'package:dio/dio.dart';
import 'package:nook/api/di/injection.dart';
import 'package:nook/api/repositories/auth_repository.dart';

class AuthInterceptor extends Interceptor {

  final AuthRepository _authRepository = getIt<AuthRepository>();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = await _authRepository.getAccessToken();

    if (accessToken != null && accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        await _authRepository.refresh();

        final newResponse = await _retryRequest(err.requestOptions);
        handler.resolve(newResponse);
      } catch (e) {
        await _authRepository.logout();
        handler.reject(err);
      }
    } else {
      handler.next(err);
    }
  }

  Future<Response> _retryRequest(RequestOptions options) async {
    final accessToken = await _authRepository.getAccessToken();
    options.headers['Authorization'] = 'Bearer $accessToken';

    final dio = Dio();
    return await dio.fetch(options);
  }
}
