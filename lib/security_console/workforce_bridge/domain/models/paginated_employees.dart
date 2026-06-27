import 'package:digify_security_console/security_console/workforce_bridge/time_management/domain/models/pagination_info.dart';
import 'package:digify_security_console/security_console/workforce_bridge/domain/models/employee.dart';

class PaginatedEmployees {
  final List<Employee> employees;
  final PaginationInfo pagination;
  final int total;
  final int count;

  const PaginatedEmployees({
    required this.employees,
    required this.pagination,
    required this.total,
    required this.count,
  });
}
