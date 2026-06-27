import 'package:digify_security_console/security_console/workforce_bridge/domain/models/position.dart';
import 'package:digify_security_console/security_console/workforce_bridge/domain/repositories/position_repository.dart';

class UpdatePositionUseCase {
  final PositionRepository repository;

  UpdatePositionUseCase({required this.repository});

  Future<Position> execute(String id, Map<String, dynamic> positionData, {int? tenantId}) async {
    return await repository.updatePosition(id, positionData, tenantId: tenantId);
  }
}
