import 'package:digify_security_console/security_console/workforce_bridge/domain/models/job_family_response.dart';
import 'package:digify_security_console/security_console/workforce_bridge/domain/repositories/job_family_repository.dart';

class GetJobFamiliesUseCase {
  final JobFamilyRepository repository;

  const GetJobFamiliesUseCase({required this.repository});

  Future<JobFamilyResponse> call({int page = 1, int pageSize = 10, String? search, int? tenantId}) async {
    return await repository.getJobFamilies(page: page, pageSize: pageSize, search: search, tenantId: tenantId);
  }
}
