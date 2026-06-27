import 'package:digify_security_console/security_console/workforce_bridge/domain/models/workforce_stats.dart';

abstract class WorkforceStatsRepository {
  Future<WorkforceStats> getWorkforceStats({int? tenantId});
}
