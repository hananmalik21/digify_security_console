import 'package:digify_security_console/integration/sc_network_providers.dart';
import 'package:digify_security_console/security_console/workforce_bridge/employee_management/domain/models/empl_lookup_value.dart';
import 'package:digify_security_console/security_console/workforce_bridge/data/datasources/ent_lookup_remote_data_source.dart';
import 'package:digify_security_console/security_console/workforce_bridge/data/repositories/ent_lookup_repository_impl.dart';
import 'package:digify_security_console/security_console/workforce_bridge/domain/repositories/ent_lookup_repository.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/providers/grade_structure_enterprise_provider.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/providers/positions_enterprise_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final entLookupRemoteDataSourceProvider = Provider<EntLookupRemoteDataSource>((ref) {
  return EntLookupRemoteDataSourceImpl(apiClient: ref.watch(apiClientProvider));
});

final entLookupRepositoryProvider = Provider<EntLookupRepository>((ref) {
  return EntLookupRepositoryImpl(remoteDataSource: ref.read(entLookupRemoteDataSourceProvider));
});

final entLookupValuesForTypeProvider = FutureProvider.autoDispose
    .family<List<EmplLookupValue>, ({int enterpriseId, String typeCode})>((ref, params) async {
      if (params.enterpriseId <= 0) return [];
      final repo = ref.watch(entLookupRepositoryProvider);
      return repo.getLookupValues(params.enterpriseId, params.typeCode);
    });

final gradeCategoryLookupValuesProvider = FutureProvider.autoDispose<List<EmplLookupValue>>((ref) async {
  final enterpriseId = ref.watch(gradeStructureEnterpriseIdProvider);
  if (enterpriseId == null) return [];
  final repo = ref.watch(entLookupRepositoryProvider);
  return repo.getLookupValues(enterpriseId, 'GRADE_CATEGORY');
});

final gradeNumberLookupValuesProvider = FutureProvider.autoDispose<List<EmplLookupValue>>((ref) async {
  final enterpriseId = ref.watch(gradeStructureEnterpriseIdProvider);
  if (enterpriseId == null) return [];
  final repo = ref.watch(entLookupRepositoryProvider);
  return repo.getLookupValues(enterpriseId, 'GRADE_NUMBER');
});

final employmentTypeLookupValuesProvider = FutureProvider.autoDispose<List<EmplLookupValue>>((ref) async {
  final enterpriseId = ref.watch(positionsEnterpriseIdProvider);
  if (enterpriseId == null) return [];
  final repo = ref.watch(entLookupRepositoryProvider);
  return repo.getLookupValues(enterpriseId, 'EMPLOYEMENT_TYPE');
});
