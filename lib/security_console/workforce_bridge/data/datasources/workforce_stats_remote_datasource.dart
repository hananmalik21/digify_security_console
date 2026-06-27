import 'package:digify_core/network/api_client.dart';
import 'package:digify_core/network/api_endpoints.dart';
import 'package:digify_core/network/exceptions.dart';
import 'package:digify_security_console/security_console/workforce_bridge/data/dtos/workforce_stats_dto.dart';
import 'package:digify_security_console/security_console/workforce_bridge/domain/models/workforce_stats.dart';

abstract class WorkforceStatsRemoteDataSource {
  Future<WorkforceStats> getWorkforceStats({int? tenantId});
}

class WorkforceStatsRemoteDataSourceImpl implements WorkforceStatsRemoteDataSource {
  final ApiClient apiClient;

  const WorkforceStatsRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<WorkforceStats> getWorkforceStats({int? tenantId}) async {
    try {
      final queryParams = <String, String>{};
      if (tenantId != null) {
        queryParams['tenant_id'] = tenantId.toString();
      }

      final response = await apiClient.get(ApiEndpoints.workforceStats, queryParameters: queryParams);

      final dto = WorkforceStatsDto.fromJson(response['data'] as Map<String, dynamic>);
      return dto.toDomain();
    } on AppException {
      rethrow;
    } catch (e) {
      throw UnknownException('Failed to fetch workforce stats: ${e.toString()}', originalError: e);
    }
  }
}
