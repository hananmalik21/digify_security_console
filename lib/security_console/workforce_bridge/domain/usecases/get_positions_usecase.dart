import 'package:digify_core/enums/position_status.dart';
import 'package:digify_security_console/security_console/workforce_bridge/domain/models/position_response.dart';
import 'package:digify_security_console/security_console/workforce_bridge/domain/repositories/position_repository.dart';

/// Get positions use case
/// Encapsulates the business logic for fetching positions
class GetPositionsUseCase {
  final PositionRepository repository;

  const GetPositionsUseCase({required this.repository});

  Future<PositionResponse> call({
    int page = 1,
    int pageSize = 10,
    String? search,
    PositionStatus? status,
    int? tenantId,
  }) async {
    return await repository.getPositions(
      page: page,
      pageSize: pageSize,
      search: search,
      status: status,
      tenantId: tenantId,
    );
  }
}
