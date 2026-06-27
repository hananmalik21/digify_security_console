import 'package:digify_security_console/security_console/workforce_bridge/data/datasources/org_unit_remote_datasource.dart';
import 'package:digify_security_console/security_console/workforce_bridge/data/repositories/org_unit_repository_impl.dart';
import 'package:digify_security_console/security_console/workforce_bridge/domain/models/org_structure_level.dart';
import 'package:digify_security_console/security_console/workforce_bridge/domain/repositories/org_unit_repository.dart';
import 'package:digify_security_console/security_console/workforce_bridge/domain/usecases/get_org_units_by_level_usecase.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/providers/enterprise_selection_provider.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/providers/job_family_providers.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/providers/positions_enterprise_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orgUnitRemoteDataSourceProvider = Provider<OrgUnitRemoteDataSource>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return OrgUnitRemoteDataSourceImpl(apiClient: apiClient);
});

final orgUnitRepositoryProvider = Provider<OrgUnitRepository>((ref) {
  return OrgUnitRepositoryImpl(remoteDataSource: ref.read(orgUnitRemoteDataSourceProvider));
});

final getOrgUnitsByLevelUseCaseProvider = Provider<GetOrgUnitsByLevelUseCase>((ref) {
  return GetOrgUnitsByLevelUseCase(repository: ref.read(orgUnitRepositoryProvider));
});

final enterpriseSelectionNotifierProvider =
    StateNotifierProvider.family<
      EnterpriseSelectionNotifier,
      EnterpriseSelectionState,
      ({List<OrgStructureLevel> levels, String structureId})
    >((ref, params) {
      final tenantId = ref.watch(positionsEnterpriseIdProvider);
      return EnterpriseSelectionNotifier(
        getOrgUnitsByLevelUseCase: ref.read(getOrgUnitsByLevelUseCaseProvider),
        levels: params.levels,
        structureId: params.structureId,
        tenantId: tenantId,
      );
    });
