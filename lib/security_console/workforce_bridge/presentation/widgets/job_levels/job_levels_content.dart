import 'package:digify_core/constants/app_colors.dart';
import 'package:digify_security_console/l10n/security_console_localizations.dart';
import 'package:digify_core/services/responsive_service.dart';
import 'package:digify_core/theme/theme_extensions.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/widgets/common/workforce_stats_cards.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/widgets/job_levels/job_levels_list_mobile.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/widgets/job_levels/job_levels_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class JobLevelsContent extends ConsumerWidget {
  const JobLevelsContent({
    required this.padding,
    required this.sectionSpacing,
    required this.header,
    required this.enterpriseSelector,
    super.key,
  });

  final EdgeInsetsGeometry padding;
  final double sectionSpacing;
  final Widget header;
  final Widget enterpriseSelector;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = SecurityConsoleLocalizations.of(context)!;
    final isDark = context.isDark;
    final isMobile = context.screenLayout.isMobile;

    return Container(
      color: isDark ? AppColors.backgroundDark : AppColors.background,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header,
            Gap(sectionSpacing),
            enterpriseSelector,
            Gap(sectionSpacing),
            WorkforceStatsCards(localizations: localizations, isDark: isDark),
            Gap(sectionSpacing),
            isMobile ? JobLevelsListMobile(localizations: localizations, isDark: isDark) : const JobLevelsTable(),
          ],
        ),
      ),
    );
  }
}
