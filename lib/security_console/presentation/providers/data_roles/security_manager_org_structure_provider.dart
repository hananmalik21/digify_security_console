import 'package:digify_security_console/security_console/presentation/providers/shared/security_manager_module_enterprise_providers.dart';
import 'package:digify_security_console/security_console/workforce_bridge/domain/usecases/get_active_org_structure_levels_usecase.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/providers/org_structure_provider.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/providers/org_structure_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SecurityManagerOrgStructureNotifier extends StateNotifier<OrgStructureState> {
  SecurityManagerOrgStructureNotifier(this._ref, this._useCase) : super(const OrgStructureState()) {
    _enterpriseSubscription = _ref.listen<int?>(
      rolesManagementEnterpriseIdProvider,
      (_, _) => loadForCurrentEnterprise(),
    );
    loadForCurrentEnterprise();
  }

  final Ref _ref;
  final GetActiveOrgStructureLevelsUseCase _useCase;
  late final ProviderSubscription<int?> _enterpriseSubscription;

  Future<void> loadForCurrentEnterprise() async {
    final enterpriseId = _ref.read(rolesManagementEnterpriseIdProvider);
    if (enterpriseId == null || enterpriseId <= 0) {
      state = const OrgStructureState();
      return;
    }

    state = const OrgStructureState(isLoading: true);

    try {
      final orgStructure = await _useCase(tenantId: enterpriseId);
      if (_ref.read(rolesManagementEnterpriseIdProvider) != enterpriseId) {
        return;
      }
      state = OrgStructureState(orgStructure: orgStructure, isLoading: false);
    } catch (e) {
      if (_ref.read(rolesManagementEnterpriseIdProvider) != enterpriseId) {
        return;
      }
      state = OrgStructureState(isLoading: false, error: e.toString());
    }
  }

  @override
  void dispose() {
    _enterpriseSubscription.close();
    super.dispose();
  }
}

final securityManagerOrgStructureNotifierProvider =
    StateNotifierProvider<SecurityManagerOrgStructureNotifier, OrgStructureState>((ref) {
      return SecurityManagerOrgStructureNotifier(ref, ref.read(getActiveOrgStructureLevelsUseCaseProvider));
    });
