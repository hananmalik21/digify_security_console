import 'package:digify_core/network/api_client.dart';
import 'package:digify_core/network/api_endpoints.dart';
import 'package:digify_security_console/security_console/workforce_bridge/data/models/reporting_relationship_model.dart';
import 'package:digify_security_console/security_console/workforce_bridge/domain/models/reporting_relationship.dart';

abstract class ReportingStructureRemoteDataSource {
  Future<List<ReportingRelationship>> getReportingRelationships({int? tenantId});
}

class ReportingStructureRemoteDataSourceImpl implements ReportingStructureRemoteDataSource {
  final ApiClient apiClient;

  const ReportingStructureRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<ReportingRelationship>> getReportingRelationships({int? tenantId}) async {
    final queryParameters = <String, String>{};
    if (tenantId != null) {
      queryParameters['tenant_id'] = tenantId.toString();
    }

    final response = await apiClient.get(ApiEndpoints.reportingRelationships, queryParameters: queryParameters);

    final data = response['data'] as List<dynamic>? ?? [];
    return data.map((e) => ReportingRelationshipModel.fromJson(e as Map<String, dynamic>).toEntity()).toList();
  }
}
