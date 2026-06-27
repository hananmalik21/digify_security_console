import 'package:digify_security_console/security_console/workforce_bridge/domain/repositories/position_repository.dart';

class DeletePositionUseCase {
  final PositionRepository repository;

  DeletePositionUseCase({required this.repository});

  Future<void> execute(String id, {bool hard = true, int? tenantId}) async {
    return await repository.deletePosition(id, hard: hard, tenantId: tenantId);
  }
}
