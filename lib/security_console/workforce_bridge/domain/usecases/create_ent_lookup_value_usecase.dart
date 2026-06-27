import 'package:digify_security_console/security_console/workforce_bridge/domain/models/ent_lookup_value_input.dart';
import 'package:digify_security_console/security_console/workforce_bridge/domain/repositories/ent_lookup_repository.dart';

class CreateEntLookupValueUseCase {
  const CreateEntLookupValueUseCase(this._repository);

  final EntLookupRepository _repository;

  Future<void> executeBulk({
    required int enterpriseId,
    required String lookupTypeCode,
    required List<EntLookupValueInput> values,
  }) {
    return _repository.createLookupValuesBulk(
      enterpriseId: enterpriseId,
      lookupTypeCode: lookupTypeCode,
      values: values,
    );
  }
}
