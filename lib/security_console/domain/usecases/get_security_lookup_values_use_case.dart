import 'package:digify_security_console/security_console/domain/models/security_lookup_value.dart';
import 'package:digify_security_console/security_console/domain/repositories/security_lookups_repository.dart';

class GetSecurityLookupValuesUseCase {
  const GetSecurityLookupValuesUseCase(this._repository);

  final SecurityLookupsRepository _repository;

  Future<List<SecurityLookupValue>> call({required int enterpriseId, required int lookupTypeId}) {
    return _repository.getLookupValues(enterpriseId: enterpriseId, lookupTypeId: lookupTypeId);
  }
}
