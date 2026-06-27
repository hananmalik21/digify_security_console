import 'package:digify_security_console/security_console/workforce_bridge/domain/repositories/job_family_repository.dart';

class DeleteJobFamilyUseCase {
  final JobFamilyRepository repository;

  const DeleteJobFamilyUseCase({required this.repository});

  Future<void> call({required int id, bool hard = true, int? tenantId}) async {
    return await repository.deleteJobFamily(id: id, hard: hard, tenantId: tenantId);
  }
}
