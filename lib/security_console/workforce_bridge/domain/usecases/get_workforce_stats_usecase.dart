import 'package:digify_security_console/security_console/workforce_bridge/domain/models/workforce_stats.dart';
import 'package:digify_security_console/security_console/workforce_bridge/domain/repositories/workforce_stats_repository.dart';

class GetWorkforceStatsUseCase {
  final WorkforceStatsRepository repository;

  const GetWorkforceStatsUseCase({required this.repository});

  Future<WorkforceStats> call({int? tenantId}) async {
    return await repository.getWorkforceStats(tenantId: tenantId);
  }
}
