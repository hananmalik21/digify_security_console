import 'package:digify_security_console/security_console/workforce_bridge/domain/models/paginated_employees.dart';

abstract class EmployeeRepository {
  Future<PaginatedEmployees> getEmployees({required int enterpriseId, String? search, int page = 1, int pageSize = 10});
}
