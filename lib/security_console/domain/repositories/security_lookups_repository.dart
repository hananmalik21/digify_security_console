import 'package:digify_security_console/security_console/domain/models/security_lookup_type.dart';
import 'package:digify_security_console/security_console/domain/models/security_lookup_value.dart';

abstract class SecurityLookupsRepository {
  Future<List<SecurityLookupType>> getLookupTypes({required int enterpriseId});

  Future<List<SecurityLookupValue>> getLookupValues({required int enterpriseId, required int lookupTypeId});
}
