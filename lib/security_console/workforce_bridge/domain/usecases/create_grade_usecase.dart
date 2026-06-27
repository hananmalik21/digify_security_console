import 'package:digify_security_console/security_console/workforce_bridge/domain/models/grade.dart';
import 'package:digify_security_console/security_console/workforce_bridge/domain/repositories/grade_repository.dart';

class CreateGradeUseCase {
  final GradeRepository repository;

  CreateGradeUseCase(this.repository);

  Future<Grade> execute(Grade grade, {int? tenantId}) {
    return repository.createGrade(grade, tenantId: tenantId);
  }
}
