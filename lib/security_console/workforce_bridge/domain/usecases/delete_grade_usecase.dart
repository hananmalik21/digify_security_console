import 'package:digify_security_console/security_console/workforce_bridge/domain/repositories/grade_repository.dart';

class DeleteGradeUseCase {
  final GradeRepository repository;

  DeleteGradeUseCase(this.repository);

  Future<void> execute(int gradeId, {int? tenantId}) {
    return repository.deleteGrade(gradeId, tenantId: tenantId);
  }
}
