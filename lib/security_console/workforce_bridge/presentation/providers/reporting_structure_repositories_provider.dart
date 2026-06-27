import 'package:digify_security_console/security_console/workforce_bridge/presentation/providers/employee_providers.dart';
import 'package:digify_security_console/security_console/workforce_bridge/data/datasources/reporting_structure_remote_datasource.dart';
import 'package:digify_security_console/security_console/workforce_bridge/data/repositories/reporting_structure_repository_impl.dart';
import 'package:digify_security_console/security_console/workforce_bridge/domain/repositories/reporting_structure_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reportingStructureRemoteDataSourceProvider = Provider<ReportingStructureRemoteDataSource>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ReportingStructureRemoteDataSourceImpl(apiClient: apiClient);
});

final reportingStructureRepositoryProvider = Provider<ReportingStructureRepository>((ref) {
  final remoteDataSource = ref.watch(reportingStructureRemoteDataSourceProvider);
  return ReportingStructureRepositoryImpl(dataSource: remoteDataSource);
});
