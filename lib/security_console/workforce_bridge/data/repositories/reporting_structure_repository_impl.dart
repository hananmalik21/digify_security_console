import 'package:digify_security_console/security_console/workforce_bridge/data/datasources/reporting_structure_remote_datasource.dart';
import 'package:digify_security_console/security_console/workforce_bridge/domain/models/reporting_relationship.dart';
import 'package:digify_security_console/security_console/workforce_bridge/domain/repositories/reporting_structure_repository.dart';

class ReportingStructureRepositoryImpl implements ReportingStructureRepository {
  final ReportingStructureRemoteDataSource dataSource;

  ReportingStructureRepositoryImpl({required this.dataSource});

  @override
  Future<List<ReportingRelationship>> getReportingRelationships({int? tenantId}) async {
    return await dataSource.getReportingRelationships(tenantId: tenantId);
  }
}
