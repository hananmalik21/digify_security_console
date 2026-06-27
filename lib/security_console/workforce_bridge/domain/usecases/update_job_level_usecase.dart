import 'package:digify_security_console/security_console/workforce_bridge/domain/models/job_level.dart';
import 'package:digify_security_console/security_console/workforce_bridge/domain/repositories/job_level_repository.dart';

class UpdateJobLevelUseCase {
  final JobLevelRepository repository;

  UpdateJobLevelUseCase(this.repository);

  Future<JobLevel> execute(JobLevel jobLevel, {int? tenantId}) {
    return repository.updateJobLevel(jobLevel, tenantId: tenantId);
  }
}
