import 'package:digify_security_console/security_console/workforce_bridge/domain/repositories/job_level_repository.dart';

class DeleteJobLevelUseCase {
  final JobLevelRepository repository;

  DeleteJobLevelUseCase(this.repository);

  Future<void> execute(int id, {int? tenantId}) {
    return repository.deleteJobLevel(id, tenantId: tenantId);
  }
}
