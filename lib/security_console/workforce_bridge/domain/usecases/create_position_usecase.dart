import 'package:digify_security_console/security_console/workforce_bridge/domain/models/position.dart';
import 'package:digify_security_console/security_console/workforce_bridge/domain/repositories/position_repository.dart';

class CreatePositionUseCase {
  final PositionRepository repository;

  CreatePositionUseCase({required this.repository});

  Future<Position> call(Map<String, dynamic> positionData, {int? tenantId}) async {
    return await repository.createPosition(positionData, tenantId: tenantId);
  }
}
