import 'package:digify_security_console/l10n/security_console_localizations.dart';
import 'package:digify_core/services/responsive/responsive_helper.dart';
import 'package:digify_core/widgets/buttons/app_mobile_button.dart';
import 'package:digify_core/widgets/common/digify_mobile_tab_header.dart';
import 'package:digify_enterprise_structure/digify_enterprise_structure.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/screens/job_families/job_families_permission_mixin.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/widgets/common/workforce_tab_config.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/widgets/job_families/job_families_content.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/widgets/job_families/job_family_form_dialog.dart';
import 'package:digify_security_console/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class JobFamiliesMobileLayout extends StatelessWidget with JobFamiliesPermissionMixin {
  const JobFamiliesMobileLayout({required this.selectedEnterpriseId, required this.onEnterpriseChanged, super.key});

  final int? selectedEnterpriseId;
  final ValueChanged<int?> onEnterpriseChanged;

  @override
  Widget build(BuildContext context) {
    final localizations = SecurityConsoleLocalizations.of(context)!;
    return JobFamiliesContent(
      padding: ResponsiveHelper.getScreenPadding(context),
      sectionSpacing: ResponsiveHelper.getTabSectionSpacing(context),
      header: DigifyMobileTabHeader(
        title: WorkforceTab.jobFamilies.label(localizations),
        trailing: canCreateJobFamily
            ? AppMobileButton.primary(
                svgPath: Assets.icons.addNewIconFigma.path,
                onPressed: () => JobFamilyFormDialog.show(context),
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
