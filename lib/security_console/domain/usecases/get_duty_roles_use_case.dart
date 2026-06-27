import 'package:digify_security_console/security_console/domain/models/duty_role.dart';
import 'package:digify_security_console/security_console/domain/repositories/duty_roles_repository.dart';

class GetDutyRolesUseCase {
  const GetDutyRolesUseCase(this._repository);

  final DutyRolesRepository _repository;

  Future<DutyRolePage> call({
    required int enterpriseId,
    String? search,
    String? categoryCode,
    int page = 1,
    int pageSize = 10,
  }) {
    return _repository.getDutyRoles(
      enterpriseId: enterpriseId,
      search: search,
      categoryCode: categoryCode,
      page: page,
      pageSize: pageSize,
    );
  }
}
