import 'package:digify_security_console/security_console/presentation/screens/user_management/user_management_permission_mixin.dart';
import 'package:flutter/material.dart';

import 'package:digify_security_console/l10n/security_console_localizations.dart';
import 'package:digify_core/services/responsive/responsive_helper.dart';
import 'package:digify_core/widgets/buttons/app_button.dart';
import 'package:digify_core/widgets/common/digify_tab_header.dart';
import 'package:digify_enterprise_structure/digify_enterprise_structure.dart';
import 'package:digify_security_console/gen/assets.gen.dart';
import 'user_management_content.dart';

class UserManagementTabletLayout extends StatelessWidget with UserManagementPermissionMixin {
  const UserManagementTabletLayout({
    required this.selectedEnterpriseId,
    required this.onEnterpriseChanged,
    required this.onCreateUserPressed,
    super.key,
  });

  final int? selectedEnterpriseId;
  final ValueChanged<int?> onEnterpriseChanged;
  final Future<void> Function()? onCreateUserPressed;

  @override
  Widget build(BuildContext context) {
    final localizations = SecurityConsoleLocalizations.of(context)!;

    return UserManagementContent(
      padding: ResponsiveHelper.getScreenPadding(context),
      header: DigifyTabHeader(
        title: localizations.userManagement,
        description: 'Manage system users, roles, and access permissions',
        trailing: canCreateUser
            ? AppButton.primary(
                label: 'Create New User',
                svgPath: Assets.icons.addNewIconFigma.path,
                onPressed: onCreateUserPressed == null ? null : () => onCreateUserPressed!(),
              )
            : null,
      ),
      enterpriseSelector: EnterpriseSelectorWidget(
        selectedEnterpriseId: selectedEnterpriseId,
        onEnterpriseChanged: onEnterpriseChanged,
      ),
    );
  }
}
