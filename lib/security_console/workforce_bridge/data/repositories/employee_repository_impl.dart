import 'package:digify_security_console/security_console/workforce_bridge/data/datasources/employee_remote_data_source.dart';
import 'package:digify_security_console/security_console/workforce_bridge/domain/models/paginated_employees.dart';
import 'package:digify_security_console/security_console/workforce_bridge/domain/repositories/employee_repository.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  final EmployeeRemoteDataSource remoteDataSource;

  EmployeeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<PaginatedEmployees> getEmployees({
    required int enterpriseId,
    String? search,
    int page = 1,
    int pageSize = 10,
  }) async {
    final dto = await remoteDataSource.getEmployees(
      enterpriseId: enterpriseId,
      search: search,
      page: page,
      pageSize: pageSize,
    );

    return dto.toDomain();
  }
}
