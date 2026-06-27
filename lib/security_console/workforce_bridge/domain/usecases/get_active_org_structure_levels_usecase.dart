import 'package:digify_security_console/security_console/workforce_bridge/domain/models/org_structure_level.dart';
import 'package:digify_security_console/security_console/workforce_bridge/domain/repositories/org_structure_repository.dart';

class GetActiveOrgStructureLevelsUseCase {
  final OrgStructureRepository repository;

  const GetActiveOrgStructureLevelsUseCase({required this.repository});

  Future<OrgStructure> call({int? tenantId}) async {
    return await repository.getActiveOrgStructureLevels(tenantId: tenantId);
  }
}
