import 'package:digify_core/network/exceptions.dart';
import 'package:digify_security_console/integration/sc_network_providers.dart';
import 'package:digify_security_console/security_console/data/repositories/security_modules/security_modules_repository_impl.dart';
import 'package:digify_security_console/security_console/domain/models/security_module.dart';
import 'package:digify_security_console/security_console/domain/repositories/security_modules_repository.dart';
import 'package:digify_security_console/security_console/domain/usecases/get_security_modules_use_case.dart';
import 'package:digify_security_console/security_console/presentation/providers/shared/security_manager_module_enterprise_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _securityModulesRepositoryProvider = Provider<SecurityModulesRepository>((ref) {
  return SecurityModulesRepositoryImpl(ref.watch(apiClientProvider));
});

final _getSecurityModulesUseCaseProvider = Provider<GetSecurityModulesUseCase>((ref) {
  return GetSecurityModulesUseCase(ref.watch(_securityModulesRepositoryProvider));
});

class SecurityModulesState {
  static const int fixedPageSize = 1000;

  const SecurityModulesState({
    this.modules = const [],
    this.isLoading = false,
    this.error,
    this.currentPage = 1,
    this.pageSize = fixedPageSize,
    this.totalItems = 0,
    this.totalPages = 1,
    this.hasNext = false,
    this.hasPrevious = false,
  });

  final List<SecurityModule> modules;
  final bool isLoading;
  final String? error;
  final int currentPage;
  final int pageSize;
  final int totalItems;
  final int totalPages;
  final bool hasNext;
  final bool hasPrevious;

  int get effectivePageSize => pageSize.clamp(1, fixedPageSize).toInt();

  SecurityModulesState copyWith({
    List<SecurityModule>? modules,
    bool? isLoading,
    String? error,
    bool clearError = false,
    int? currentPage,
    int? pageSize,
    int? totalItems,
    int? totalPages,
    bool? hasNext,
    bool? hasPrevious,
  }) {
    return SecurityModulesState(
      modules: modules ?? this.modules,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      currentPage: currentPage ?? this.currentPage,
      pageSize: (pageSize ?? this.pageSize).clamp(1, fixedPageSize).toInt(),
      totalItems: totalItems ?? this.totalItems,
      totalPages: totalPages ?? this.totalPages,
      hasNext: hasNext ?? this.hasNext,
      hasPrevious: hasPrevious ?? this.hasPrevious,
    );
  }
}

class SecurityModulesNotifier extends StateNotifier<SecurityModulesState> {
  SecurityModulesNotifier(this._useCase, this._ref) : super(const SecurityModulesState());

  final GetSecurityModulesUseCase _useCase;
  final Ref _ref;

  /// Loads modules for [enterpriseId], or resolves it from the Roles
  /// Management tab selection via [rolesManagementEnterpriseIdProvider].
  Future<void> load({int? enterpriseId, int page = 1}) async {
    final id = enterpriseId ?? _ref.read(rolesManagementEnterpriseIdProvider);
    if (id == null) {
      state = const SecurityModulesState(modules: [], isLoading: false, error: 'Select an enterprise to load modules');
      return;
    }

    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final result = await _useCase(enterpriseId: id, page: page, pageSize: state.effectivePageSize);
      state = state.copyWith(
        modules: result.modules,
        isLoading: false,
        currentPage: result.page,
        totalItems: result.total,
        totalPages: result.totalPages,
        hasNext: result.hasNext,
        hasPrevious: result.hasPrevious,
      );
    } on AppException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Failed to load modules: ${e.toString()}');
    }
  }
}

final securityModulesProvider = StateNotifierProvider<SecurityModulesNotifier, SecurityModulesState>((ref) {
  return SecurityModulesNotifier(ref.watch(_getSecurityModulesUseCaseProvider), ref);
});
