import 'package:digify_core/permissions/perm_keys.dart';
import 'package:digify_core/permissions/permission_service.dart';

mixin ReportingStructurePermissionMixin {
  bool get canViewReportingStructure => PermissionService.instance.can(PermKeys.workforceReportingStructureView);
}
