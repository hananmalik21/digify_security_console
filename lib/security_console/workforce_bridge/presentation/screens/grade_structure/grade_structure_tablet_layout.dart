import 'package:digify_security_console/l10n/security_console_localizations.dart';
import 'package:digify_core/services/responsive/responsive_helper.dart';
import 'package:digify_core/widgets/common/digify_tab_header.dart';
import 'package:digify_enterprise_structure/digify_enterprise_structure.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/screens/grade_structure/grade_structure_permission_mixin.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/widgets/common/workforce_header_actions.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/widgets/common/workforce_tab_config.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/widgets/grade_structure/grade_structure_content.dart';
import 'package:flutter/material.dart';

class GradeStructureTabletLayout extends StatelessWidget with GradeStructurePermissionMixin {
  const GradeStructureTabletLayout({required this.selectedEnterpriseId, required this.onEnterpriseChanged, super.key});

  final int? selectedEnterpriseId;
  final ValueChanged<int?> onEnterpriseChanged;

  @override
  Widget build(BuildContext context) {
    final localizations = SecurityConsoleLocalizations.of(context)!;

    return GradeStructureContent(
      padding: ResponsiveHelper.getScreenPadding(context),
      sectionSpacing: ResponsiveHelper.getTabSectionSpacing(context),
      header: DigifyTabHeader(
        title: WorkforceTab.gradeStructure.label(localizations),
        trailing: WorkforceHeaderActions.getTrailingAction(context, WorkforceTab.gradeStructure),
      ),
      enterpriseSelector: EnterpriseSelectorWidget(
        selectedEnterpriseId: selectedEnterpriseId,
        onEnterpriseChanged: onEnterpriseChanged,
      ),
    );
  }
}
