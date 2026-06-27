import 'package:digify_security_console/security_console/workforce_bridge/employee_management/domain/models/empl_lookup_type.dart';
import 'package:digify_security_console/security_console/workforce_bridge/employee_management/domain/models/empl_lookup_value.dart';

abstract class EmplLookupRepository {
  Future<List<EmplLookupType>> getLookupTypes(int enterpriseId);
  Future<List<EmplLookupValue>> getLookupValues(int enterpriseId, String lookupTypeCode);
}
