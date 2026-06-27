import 'package:digify_security_console/security_console/domain/models/job_role.dart';
import 'package:digify_security_console/security_console/domain/repositories/job_roles_repository.dart';

class GetJobRolesUseCase {
  const GetJobRolesUseCase(this._repository);

  final JobRolesRepository _repository;

  Future<JobRolePage> call({required int enterpriseId, required int page, required int pageSize, String? search}) {
    return _repository.getJobRoles(enterpriseId: enterpriseId, page: page, pageSize: pageSize, search: search);
  }
}
