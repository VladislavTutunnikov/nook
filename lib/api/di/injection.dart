import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:nook/api/interceptors/auth_interceptor.dart';
import 'package:nook/api/nook_api.dart';
import 'package:nook/api/repositories/auth_repository.dart';
import 'package:nook/api/repositories/user_repository.dart';
import 'package:nook/core/storage/secure_storage.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  getIt.registerLazySingleton<String>(() => dotenv.env['API_URL'] ?? '');

  getIt.registerLazySingleton<SecureStorage>(() => SecureStorage());

  getIt.registerLazySingleton<Dio>(() {
    final dio = Dio();
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);
    return dio;
  });

  getIt.registerLazySingleton<NookApiClient>(() {
    final apiUrl = getIt<String>();
    final dio = getIt<Dio>();

    if (apiUrl.isNotEmpty) {
      return NookApiClient(dio, baseUrl: apiUrl);
    }
    return NookApiClient(dio);
  });

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepository(
      apiClient: getIt<NookApiClient>(),
      secureStorage: getIt<SecureStorage>(),
    ),
  );

  getIt.registerLazySingleton<UserRepository>(
    () => UserRepository(apiClient: getIt<NookApiClient>()),
  );

  getIt.registerLazySingleton<AuthInterceptor>(() => AuthInterceptor());

  getIt<Dio>().interceptors.add(getIt<AuthInterceptor>());
}
