import 'package:digify_core/network/api_client.dart';
import 'package:digify_core/network/api_config.dart';
import 'package:digify_core/network/auth_token_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authTokenStorageProvider = Provider<AuthTokenStorage>((ref) => const EmptyAuthTokenStorage());

final apiBaseUrlProvider = Provider<String>((ref) => ApiConfig.defaultBaseUrl);

final scApiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(
    baseUrl: ref.watch(apiBaseUrlProvider),
    authStorage: ref.watch(authTokenStorageProvider),
  );
});

final scDioProvider = Provider<Dio>((ref) => ref.watch(scApiClientProvider).dio);
