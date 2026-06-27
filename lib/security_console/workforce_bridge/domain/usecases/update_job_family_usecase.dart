import 'package:digify_security_console/security_console/workforce_bridge/domain/models/job_family.dart';
import 'package:digify_security_console/security_console/workforce_bridge/domain/repositories/job_family_repository.dart';

class UpdateJobFamilyUseCase {
  final JobFamilyRepository repository;

  const UpdateJobFamilyUseCase({required this.repository});

  Future<JobFamily> call({
    required int id,
    required String code,
    required String nameEnglish,
    String nameArabic = '',
    required String description,
    String status = 'ACTIVE',
    int? tenantId,
  }) async {
    return await repository.updateJobFamily(
      id: id,
      code: code,
      nameEnglish: nameEnglish,
      nameArabic: nameArabic,
      description: description,
      status: status,
      tenantId: tenantId,
    );
  }
}
