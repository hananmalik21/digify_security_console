import 'package:digify_security_console/security_console/workforce_bridge/employee_management/domain/models/empl_lookup_value.dart';
import 'package:digify_security_console/security_console/workforce_bridge/domain/models/ent_lookup_type.dart';
import 'package:digify_security_console/security_console/workforce_bridge/domain/models/ent_lookup_value_input.dart';

abstract class EntLookupRepository {
  Future<List<EmplLookupValue>> getLookupValues(int enterpriseId, String lookupTypeCode);
  Future<List<EntLookupType>> getLookupTypes(int enterpriseId);
  Future<void> createLookupValuesBulk({
    required int enterpriseId,
    required String lookupTypeCode,
    required List<EntLookupValueInput> values,
  });
}
