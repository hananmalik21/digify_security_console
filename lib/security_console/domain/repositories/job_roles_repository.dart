import 'package:digify_security_console/security_console/domain/models/job_role.dart';

abstract class JobRolesRepository {
  Future<JobRolePage> getJobRoles({
    required int enterpriseId,
    required int page,
    required int pageSize,
    String? search,
  });

  Future<void> deleteJobRole({required String jobRoleGuid});

  Future<void> createJobRole({required Map<String, dynamic> body});

  Future<void> updateJobRole({required String jobRoleGuid, required Map<String, dynamic> body});
}
