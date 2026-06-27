import 'package:digify_security_console/l10n/security_console_localizations.dart';
import 'package:digify_core/permissions/perm_keys.dart';
import 'package:digify_core/permissions/permission_service.dart';
import 'package:digify_core/widgets/buttons/app_button.dart';
import 'package:digify_security_console/security_console/workforce_bridge/domain/models/position.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/widgets/common/workforce_tab_config.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/widgets/grade_structure/create_grade_dialog.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/widgets/job_families/job_family_form_dialog.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/widgets/job_levels/job_level_form_dialog.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/widgets/positions/position_form_dialog.dart';
import 'package:digify_security_console/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class WorkforceHeaderActions {
  static Widget? getTrailingAction(
    BuildContext context,
    WorkforceTab currentTab, {
    VoidCallback? onExport,
    bool isExporting = false,
  }) {
    final localizations = SecurityConsoleLocalizations.of(context)!;

    switch (currentTab) {
      case WorkforceTab.positions:
        if (!PermissionService.instance.can(PermKeys.workforcePositionsCreate)) return null;
        return AppButton.primary(
          label: localizations.addPosition,
          svgPath: Assets.icons.addDivisionIcon.path,
          onPressed: () => PositionFormDialog.show(context, position: Position.empty(), isEdit: false),
        );
      case WorkforceTab.jobFamilies:
        if (!PermissionService.instance.can(PermKeys.workforceJobFamiliesCreate)) return null;
        return AppButton.primary(
          label: localizations.addJobFamily,
          svgPath: Assets.icons.addNewIconFigma.path,
          onPressed: () => JobFamilyFormDialog.show(context),
        );
      case WorkforceTab.jobLevels:
        if (!PermissionService.instance.can(PermKeys.workforceJobLevelsCreate)) return null;
        return AppButton.primary(
          label: localizations.addJobLevel,
          svgPath: Assets.icons.addNewIconFigma.path,
          onPressed: () => JobLevelFormDialog.show(context, onSave: (level) {}),
        );
      case WorkforceTab.gradeStructure:
        if (!PermissionService.instance.can(PermKeys.workforceGradeStructureCreate)) return null;
        return AppButton.primary(
          label: localizations.addGrade,
          svgPath: Assets.icons.addNewIconFigma.path,
          onPressed: () => CreateGradeDialog.show(context),
        );
      case WorkforceTab.reportingStructure:
        if (!PermissionService.instance.can(PermKeys.workforceReportingStructureView)) return null;
        return AppButton.primary(
          label: localizations.exportTable,
          svgPath: Assets.icons.downloadIcon.path,
          onPressed: isExporting ? null : onExport,
          isLoading: isExporting,
        );
      default:
        return null;
    }
  }
}
