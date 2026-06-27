import 'package:digify_core/enums/position_status.dart';
import 'package:digify_security_console/security_console/workforce_bridge/domain/models/position_response.dart';
import 'package:digify_security_console/security_console/workforce_bridge/domain/repositories/position_repository.dart';

class GetPositionsByOrgUnitUseCase {
  final PositionRepository repository;

  const GetPositionsByOrgUnitUseCase({required this.repository});

  Future<PositionResponse> call({
    required String orgUnitId,
    int page = 1,
    int pageSize = 10,
    String? search,
    PositionStatus? status,
    int? tenantId,
  }) async {
    return repository.getPositionsByOrgUnit(
      orgUnitId: orgUnitId,
      page: page,
      pageSize: pageSize,
      search: search,
      status: status,
      tenantId: tenantId,
    );
  }
}
