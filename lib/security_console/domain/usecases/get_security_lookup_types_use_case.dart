import 'package:digify_security_console/security_console/domain/models/security_lookup_type.dart';
import 'package:digify_security_console/security_console/domain/repositories/security_lookups_repository.dart';

class GetSecurityLookupTypesUseCase {
  const GetSecurityLookupTypesUseCase(this._repository);

  final SecurityLookupsRepository _repository;

  Future<List<SecurityLookupType>> call({required int enterpriseId}) {
    return _repository.getLookupTypes(enterpriseId: enterpriseId);
  }
}
