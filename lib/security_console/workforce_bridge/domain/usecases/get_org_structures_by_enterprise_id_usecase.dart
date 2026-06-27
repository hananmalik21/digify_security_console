import 'package:digify_security_console/security_console/workforce_bridge/domain/models/org_structure_level.dart';
import 'package:digify_security_console/security_console/workforce_bridge/domain/repositories/org_structure_repository.dart';

class GetOrgStructuresByEnterpriseIdUseCase {
  final OrgStructureRepository repository;

  const GetOrgStructuresByEnterpriseIdUseCase({required this.repository});

  Future<List<OrgStructure>> call(int enterpriseId) async {
    return await repository.getOrgStructuresByEnterpriseId(enterpriseId);
  }
}
