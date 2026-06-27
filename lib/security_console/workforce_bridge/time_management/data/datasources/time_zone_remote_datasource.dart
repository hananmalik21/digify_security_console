import 'package:digify_core/network/api_client.dart';
import 'package:digify_core/network/api_endpoints.dart';
import 'package:digify_core/network/exceptions.dart';
import 'package:digify_security_console/security_console/workforce_bridge/time_management/data/dto/time_zones_response_dto.dart';

abstract class TimeZoneRemoteDataSource {
  Future<TimeZonesResponseDto> getTimeZones({String? name, int page = 1, int pageSize = 25});
}

class TimeZoneRemoteDataSourceImpl implements TimeZoneRemoteDataSource {
  final ApiClient apiClient;

  const TimeZoneRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<TimeZonesResponseDto> getTimeZones({String? name, int page = 1, int pageSize = 25}) async {
    try {
      final queryParameters = <String, String>{'page': page.toString(), 'page_size': pageSize.toString()};
      if (name != null && name.trim().isNotEmpty) {
        queryParameters['name'] = name.trim();
      }
      final response = await apiClient.get(ApiEndpoints.tmTimeZones, queryParameters: queryParameters);
      return TimeZonesResponseDto.fromJson(response);
    } on AppException {
      rethrow;
    } catch (e) {
      throw UnknownException('Failed to fetch time zones: ${e.toString()}', originalError: e);
    }
  }
}
