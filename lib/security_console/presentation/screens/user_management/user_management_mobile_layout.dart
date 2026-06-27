import 'package:digify_security_console/security_console/presentation/screens/user_management/user_management_permission_mixin.dart';
import 'package:flutter/material.dart';

import 'package:digify_core/services/responsive/responsive_helper.dart';
import 'package:digify_core/widgets/buttons/app_mobile_button.dart';
import 'package:digify_core/widgets/common/digify_mobile_tab_header.dart';
import 'package:digify_enterprise_structure/digify_enterprise_structure.dart';
import 'package:digify_security_console/gen/assets.gen.dart';
import 'user_management_content.dart';

class UserManagementMobileLayout extends StatelessWidget with UserManagementPermissionMixin {
  const UserManagementMobileLayout({
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
    return UserManagementContent(
      padding: ResponsiveHelper.getScreenPadding(context),
      header: DigifyMobileTabHeader(
        title: 'User Management',
        trailing: canCreateUser
            ? AppMobileButton.primary(
                svgPath: Assets.icons.addNewIconFigma.path,
                onPressed: () => onCreateUserPressed!(),
              )
            : null,
      ),
      enterpriseSelector: EnterpriseSelectorMobileWidget(
        selectedEnterpriseId: selectedEnterpriseId,
        onEnterpriseChanged: onEnterpriseChanged,
      ),
    );
  }
}
