import 'package:digify_security_console/security_console/workforce_bridge/domain/models/org_structure_level.dart';

abstract class OrgStructureRepository {
  Future<OrgStructure> getActiveOrgStructureLevels({int? tenantId});
  Future<List<OrgStructure>> getOrgStructuresByEnterpriseId(int enterpriseId, {int? tenantId});
}
