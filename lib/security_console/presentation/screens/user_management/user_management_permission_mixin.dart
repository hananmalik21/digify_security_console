import 'package:digify_core/permissions/perm_keys.dart';
import 'package:digify_core/permissions/permission_service.dart';

mixin UserManagementPermissionMixin {
  bool get canCreateUser => PermissionService.instance.can(PermKeys.securityUserManagementCreate);

  bool get canViewUser => PermissionService.instance.can(PermKeys.securityUserManagementView);

  bool get canUpdateUser => PermissionService.instance.can(PermKeys.securityUserManagementUpdate);

  bool get canDeleteUser => PermissionService.instance.can(PermKeys.securityUserManagementDelete);
}
