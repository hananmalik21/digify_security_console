import 'package:digify_security_console/security_console/workforce_bridge/domain/models/grade.dart';
import 'package:digify_security_console/security_console/workforce_bridge/domain/repositories/grade_repository.dart';

class UpdateGradeUseCase {
  final GradeRepository repository;

  UpdateGradeUseCase(this.repository);

  Future<Grade> execute(int gradeId, Grade grade, {int? tenantId}) {
    return repository.updateGrade(gradeId, grade, tenantId: tenantId);
  }
}
