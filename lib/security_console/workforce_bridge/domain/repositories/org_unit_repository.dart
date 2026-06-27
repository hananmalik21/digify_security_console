import 'package:digify_security_console/security_console/workforce_bridge/domain/models/org_unit.dart';
import 'package:digify_security_console/security_console/workforce_bridge/domain/models/org_unit_hierarchy_item.dart';

abstract class OrgUnitRepository {
  Future<OrgUnitsResponse> getOrgUnitsByLevel({
    required String structureId,
    required String levelCode,
    String? parentOrgUnitId,
    String? search,
    int? tenantId,
    int page = 1,
    int pageSize = 100,
  });

  Future<List<OrgUnitHierarchyItem>> getOrgUnitHierarchy({required int enterpriseId, required String orgUnitId});
}
