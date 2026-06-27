import 'package:digify_security_console/l10n/security_console_localizations.dart';
import 'package:digify_core/services/responsive/responsive_helper.dart';
import 'package:digify_core/widgets/common/digify_mobile_tab_header.dart';
import 'package:digify_enterprise_structure/digify_enterprise_structure.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/screens/reporting_structure/reporting_structure_permission_mixin.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/widgets/common/workforce_header_actions.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/widgets/common/workforce_tab_config.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/widgets/reporting_structure/reporting_structure_content.dart';
import 'package:flutter/material.dart';

class ReportingStructureMobileLayout extends StatelessWidget with ReportingStructurePermissionMixin {
  const ReportingStructureMobileLayout({
    required this.selectedEnterpriseId,
    required this.onEnterpriseChanged,
    this.onExport,
    this.isExporting = false,
    super.key,
  });

  final int? selectedEnterpriseId;
  final ValueChanged<int?> onEnterpriseChanged;
  final VoidCallback? onExport;
  final bool isExporting;

  @override
  Widget build(BuildContext context) {
    final localizations = SecurityConsoleLocalizations.of(context)!;

    return ReportingStructureContent(
      padding: ResponsiveHelper.getScreenPadding(context),
      sectionSpacing: ResponsiveHelper.getTabSectionSpacing(context),
      header: DigifyMobileTabHeader(
        title: WorkforceTab.reportingStructure.label(localizations),
        trailing: WorkforceHeaderActions.getTrailingAction(
          context,
          WorkforceTab.reportingStructure,
          onExport: onExport,
          isExporting: isExporting,
        ),
      ),
      enterpriseSelector: EnterpriseSelectorMobileWidget(
        selectedEnterpriseId: selectedEnterpriseId,
        onEnterpriseChanged: onEnterpriseChanged,
      ),
    );
  }
}
