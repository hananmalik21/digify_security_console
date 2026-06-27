import 'package:digify_security_console/integration/sc_network_providers.dart';
import 'package:digify_security_console/security_console/data/repositories/function_roles/function_roles_repository_impl.dart';
import 'package:digify_security_console/security_console/domain/repositories/function_roles_repository.dart';
import 'package:digify_security_console/security_console/domain/usecases/get_function_roles_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final functionRolesRepositoryProvider = Provider<FunctionRolesRepository>((ref) {
  return FunctionRolesRepositoryImpl(ref.watch(apiClientProvider));
});

final getFunctionRolesUseCaseProvider = Provider<GetFunctionRolesUseCase>((ref) {
  return GetFunctionRolesUseCase(ref.watch(functionRolesRepositoryProvider));
});
