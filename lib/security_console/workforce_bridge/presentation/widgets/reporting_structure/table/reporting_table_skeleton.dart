import 'package:digify_security_console/l10n/security_console_localizations.dart';
import 'package:digify_security_console/security_console/workforce_bridge/domain/models/reporting_position.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/widgets/reporting_structure/table/reporting_table_row.dart';
import 'package:flutter/material.dart';

class ReportingTableSkeleton extends StatelessWidget {
  final SecurityConsoleLocalizations localizations;

  const ReportingTableSkeleton({super.key, required this.localizations});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        5,
        (index) => ReportingTableRow(
          position: ReportingPosition(
            positionId: 'skeleton-$index',
            positionCode: 'POS-001',
            titleEnglish: 'Position Title',
            titleArabic: 'Position Title',
            department: 'Department',
            level: 'Level',
            gradeStep: 'Grade/Step',
            reportsToTitle: 'Reports To',
            reportsToCode: 'CODE',
            directReportsCount: 0,
            status: 'active',
          ),
          isDark: false,
          localizations: localizations,
        ),
      ),
    );
  }
}
