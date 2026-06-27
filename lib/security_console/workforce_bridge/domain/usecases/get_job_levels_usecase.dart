import 'package:digify_security_console/security_console/workforce_bridge/domain/models/job_level_response.dart';
import 'package:digify_security_console/security_console/workforce_bridge/domain/repositories/job_level_repository.dart';

class GetJobLevelsUseCase {
  final JobLevelRepository repository;

  GetJobLevelsUseCase(this.repository);

  Future<JobLevelResponse> execute({int page = 1, int pageSize = 10, String? search, int? tenantId}) {
    return repository.getJobLevels(page: page, pageSize: pageSize, search: search, tenantId: tenantId);
  }
}
