import 'package:digify_security_console/l10n/security_console_localizations.dart';
import 'package:digify_security_console/gen/assets.gen.dart';

enum WorkforceTab {
  positions,
  jobFamilies,
  jobLevels,
  gradeStructure,
  reportingStructure,
  positionTree;

  String label(SecurityConsoleLocalizations localizations) {
    switch (this) {
      case WorkforceTab.positions:
        return localizations.positions;
      case WorkforceTab.jobFamilies:
        return localizations.jobFamilies;
      case WorkforceTab.jobLevels:
        return localizations.jobLevels;
      case WorkforceTab.gradeStructure:
        return localizations.gradeStructure;
      case WorkforceTab.reportingStructure:
        return localizations.reportingStructure;
      case WorkforceTab.positionTree:
        return localizations.positionTree;
    }
  }

  String iconPath() {
    switch (this) {
      case WorkforceTab.positions:
        return Assets.icons.businessUnitCardIcon.path;
      case WorkforceTab.jobFamilies:
        return Assets.icons.hierarchyIconDepartment.path;
      case WorkforceTab.jobLevels:
        return Assets.icons.levelsIcon.path;
      case WorkforceTab.gradeStructure:
        return Assets.icons.gradeIcon.path;
      case WorkforceTab.reportingStructure:
        return Assets.icons.hierarchyIconDepartment.path;
      case WorkforceTab.positionTree:
        return Assets.icons.hierarchyIconDepartment.path;
    }
  }
}
