import 'package:digify_security_console/security_console/workforce_bridge/domain/models/grade.dart';
import 'package:digify_security_console/security_console/workforce_bridge/domain/models/job_level_response.dart';

/// Grade response with pagination
class GradeResponse {
  final List<Grade> data;
  final JobLevelMeta meta;

  const GradeResponse({required this.data, required this.meta});
}
