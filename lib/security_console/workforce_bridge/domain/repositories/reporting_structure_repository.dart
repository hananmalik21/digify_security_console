import 'package:digify_security_console/security_console/workforce_bridge/domain/models/reporting_relationship.dart';

abstract class ReportingStructureRepository {
  Future<List<ReportingRelationship>> getReportingRelationships({int? tenantId});
}
