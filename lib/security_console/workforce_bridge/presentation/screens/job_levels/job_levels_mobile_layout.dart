import 'package:digify_security_console/l10n/security_console_localizations.dart';
import 'package:digify_core/services/responsive/responsive_helper.dart';
import 'package:digify_core/widgets/buttons/app_mobile_button.dart';
import 'package:digify_core/widgets/common/digify_mobile_tab_header.dart';
import 'package:digify_enterprise_structure/digify_enterprise_structure.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/screens/job_levels/job_levels_permission_mixin.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/widgets/common/workforce_tab_config.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/widgets/job_levels/job_level_form_dialog.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/widgets/job_levels/job_levels_content.dart';
import 'package:digify_security_console/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class JobLevelsMobileLayout extends StatelessWidget with JobLevelsPermissionMixin {
  const JobLevelsMobileLayout({required this.selectedEnterpriseId, required this.onEnterpriseChanged, super.key});

  final int? selectedEnterpriseId;
  final ValueChanged<int?> onEnterpriseChanged;

  @override
  Widget build(BuildContext context) {
    final localizations = SecurityConsoleLocalizations.of(context)!;

    return JobLevelsContent(
      padding: ResponsiveHelper.getScreenPadding(context),
      sectionSpacing: ResponsiveHelper.getTabSectionSpacing(context),
      header: DigifyMobileTabHeader(
        title: WorkforceTab.jobLevels.label(localizations),
        trailing: canCreateJobLevel
            ? AppMobileButton.primary(
                svgPath: Assets.icons.addNewIconFigma.path,
                onPressed: () => JobLevelFormDialog.show(context),
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
