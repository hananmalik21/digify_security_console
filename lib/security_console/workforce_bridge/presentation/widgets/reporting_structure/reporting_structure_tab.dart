import 'package:digify_security_console/integration/sc_spreadsheet_export_provider.dart';
import 'package:digify_security_console/l10n/security_console_localizations.dart';
import 'package:digify_security_console/integration/sc_spreadsheet_export_provider.dart';
import 'package:digify_core/services/responsive_service.dart';
import 'package:digify_core/widgets/common/app_unauthorized_state.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/providers/reporting_structure_enterprise_provider.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/providers/reporting_structure_provider.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/screens/reporting_structure/reporting_structure_desktop_layout.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/screens/reporting_structure/reporting_structure_mobile_layout.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/screens/reporting_structure/reporting_structure_permission_mixin.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/screens/reporting_structure/reporting_structure_tablet_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReportingStructureTab extends ConsumerStatefulWidget {
  const ReportingStructureTab({super.key});

  @override
  ConsumerState<ReportingStructureTab> createState() => _ReportingStructureTabState();
}

class _ReportingStructureTabState extends ConsumerState<ReportingStructureTab> with ReportingStructurePermissionMixin {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(reportingStructureNotifierProvider.notifier).refresh());
  }

  void _onEnterpriseChanged(int? enterpriseId) {
    ref.read(reportingStructureSelectedEnterpriseProvider.notifier).setEnterpriseId(enterpriseId);
  }

  void _onExport(SecurityConsoleLocalizations localizations) {
    final enterpriseId = ref.read(reportingStructureEnterpriseIdProvider);
    ref
        .read(spreadsheetExportProvider.notifier)
        .export(
          context,
          enterpriseId: enterpriseId,
          config: ScSpreadsheetExportConfigs.reportingStructure(localizations),
        );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = SecurityConsoleLocalizations.of(context)!;
    final selectedEnterpriseId = ref.watch(reportingStructureEnterpriseIdProvider);
    final isExporting = ref.watch(spreadsheetExportProvider);
    final layout = context.screenLayout;

    if (!canViewReportingStructure) return const AppUnauthorizedState();

    if (layout.isMobile) {
      return ReportingStructureMobileLayout(
        selectedEnterpriseId: selectedEnterpriseId,
        onEnterpriseChanged: _onEnterpriseChanged,
        onExport: () => _onExport(localizations),
        isExporting: isExporting,
      );
    }

    if (layout.isTablet) {
      return ReportingStructureTabletLayout(
        selectedEnterpriseId: selectedEnterpriseId,
        onEnterpriseChanged: _onEnterpriseChanged,
        onExport: () => _onExport(localizations),
        isExporting: isExporting,
      );
    }

    return ReportingStructureDesktopLayout(
      selectedEnterpriseId: selectedEnterpriseId,
      onEnterpriseChanged: _onEnterpriseChanged,
      onExport: () => _onExport(localizations),
      isExporting: isExporting,
    );
  }
}
