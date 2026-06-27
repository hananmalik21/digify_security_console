import 'package:digify_security_console/security_console/workforce_bridge/domain/models/grade_response.dart';
import 'package:digify_security_console/security_console/workforce_bridge/domain/repositories/grade_repository.dart';

class GetGradesUseCase {
  final GradeRepository repository;

  GetGradesUseCase(this.repository);

  Future<GradeResponse> execute({int page = 1, int pageSize = 10, String? search, int? tenantId}) {
    return repository.getGrades(page: page, pageSize: pageSize, search: search, tenantId: tenantId);
  }
}
