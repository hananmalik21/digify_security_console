import 'package:digify_security_console/security_console/workforce_bridge/employee_management/domain/models/empl_lookup_value.dart';
import 'package:digify_security_console/security_console/workforce_bridge/data/datasources/ent_lookup_remote_data_source.dart';
import 'package:digify_security_console/security_console/workforce_bridge/data/dto/create_ent_lookup_values_bulk_request_dto.dart';
import 'package:digify_security_console/security_console/workforce_bridge/data/mappers/ent_lookup_value_mapper.dart';
import 'package:digify_security_console/security_console/workforce_bridge/domain/models/ent_lookup_value_input.dart';
import 'package:digify_security_console/security_console/workforce_bridge/domain/models/ent_lookup_type.dart';
import 'package:digify_security_console/security_console/workforce_bridge/domain/repositories/ent_lookup_repository.dart';

class EntLookupRepositoryImpl implements EntLookupRepository {
  EntLookupRepositoryImpl({required this.remoteDataSource});
  final EntLookupRemoteDataSource remoteDataSource;

  @override
  Future<List<EmplLookupValue>> getLookupValues(int enterpriseId, String lookupTypeCode) async {
    const pageSize = 100;
    final response = await remoteDataSource.getLookupValues(enterpriseId, lookupTypeCode, page: 1, pageSize: pageSize);
    List<EmplLookupValue> all = response.toDomain();
    for (var page = 2; page <= response.meta.totalPages; page++) {
      final next = await remoteDataSource.getLookupValues(enterpriseId, lookupTypeCode, page: page, pageSize: pageSize);
      all = [...all, ...next.toDomain()];
    }
    return all;
  }

  @override
  Future<List<EntLookupType>> getLookupTypes(int enterpriseId) async {
    final response = await remoteDataSource.getLookupTypes(enterpriseId);
    return response.data
        .map(
          (dto) => EntLookupType(
            lookupTypeId: dto.lookupTypeId,
            enterpriseId: dto.enterpriseId,
            typeCode: dto.typeCode,
            typeName: dto.typeName,
          ),
        )
        .toList();
  }

  @override
  Future<void> createLookupValuesBulk({
    required int enterpriseId,
    required String lookupTypeCode,
    required List<EntLookupValueInput> values,
  }) async {
    if (values.isEmpty) return;

    final types = await getLookupTypes(enterpriseId);
    final lookupType = types.where((t) => t.typeCode == lookupTypeCode).firstOrNull;
    if (lookupType == null) {
      throw Exception('Lookup type not found: $lookupTypeCode');
    }

    final request = CreateEntLookupValuesBulkRequestDto(
      enterpriseId: lookupType.enterpriseId ?? enterpriseId,
      lookupTypeId: lookupType.lookupTypeId,
      lookupType: lookupTypeCode,
      values: EntLookupValueMapper.toBulkItems(values),
    );

    await remoteDataSource.createLookupValuesBulk(request);
  }
}
