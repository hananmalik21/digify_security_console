import 'package:digify_security_console/security_console/workforce_bridge/data/datasources/org_structure_remote_datasource.dart';
import 'package:digify_security_console/security_console/workforce_bridge/domain/models/org_structure_level.dart';
import 'package:digify_security_console/security_console/workforce_bridge/domain/repositories/org_structure_repository.dart';

class OrgStructureRepositoryImpl implements OrgStructureRepository {
  final OrgStructureRemoteDataSource remoteDataSource;

  const OrgStructureRepositoryImpl({required this.remoteDataSource});

  @override
  Future<OrgStructure> getActiveOrgStructureLevels({int? tenantId}) async {
    return await remoteDataSource.getActiveOrgStructureLevels(tenantId: tenantId);
  }

  @override
  Future<List<OrgStructure>> getOrgStructuresByEnterpriseId(int enterpriseId, {int? tenantId}) async {
    return await remoteDataSource.getOrgStructuresByEnterpriseId(enterpriseId, tenantId: tenantId);
  }
}
