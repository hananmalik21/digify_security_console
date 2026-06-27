import 'package:digify_core/permissions/perm_keys.dart';
import 'package:digify_core/permissions/permission_service.dart';

mixin PositionsPermissionMixin {
  bool get canCreatePosition => PermissionService.instance.can(PermKeys.workforcePositionsCreate);

  bool get canViewPosition => PermissionService.instance.can(PermKeys.workforcePositionsView);

  bool get canUpdatePosition => PermissionService.instance.can(PermKeys.workforcePositionsUpdate);

  bool get canDeletePosition => PermissionService.instance.can(PermKeys.workforcePositionsDelete);
}
