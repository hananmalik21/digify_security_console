import 'package:digify_core/network/api_client.dart';
import 'package:digify_core/network/api_config.dart';
import 'package:digify_security_console/security_console/data/repositories/function_roles/function_roles_repository_impl.dart';
import 'package:digify_security_console/security_console/domain/repositories/function_roles_repository.dart';
import 'package:digify_security_console/security_console/domain/usecases/get_function_roles_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final functionRolesApiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(baseUrl: ApiConfig.baseUrl);
});

final functionRolesRepositoryProvider = Provider<FunctionRolesRepository>((ref) {
  return FunctionRolesRepositoryImpl(ref.watch(functionRolesApiClientProvider));
});

final getFunctionRolesUseCaseProvider = Provider<GetFunctionRolesUseCase>((ref) {
  return GetFunctionRolesUseCase(ref.watch(functionRolesRepositoryProvider));
});
