import 'package:digify_core/constants/app_colors.dart';
import 'package:digify_security_console/l10n/security_console_localizations.dart';
import 'package:digify_core/theme/app_shadows.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/providers/job_family_providers.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/widgets/positions/search/workforce_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JobFamiliesFilterBarMobile extends ConsumerWidget {
  const JobFamiliesFilterBarMobile({super.key, required this.localizations, required this.isDark});

  final SecurityConsoleLocalizations localizations;
  final bool isDark;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardBackgroundDark : Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: AppShadows.primaryShadow,
      ),
      child: WorkforceSearchBar(
        hintText: localizations.search,
        isDark: isDark,
        width: double.infinity,
        onSearchChanged: (value) => ref.read(jobFamilyNotifierProvider.notifier).search(value),
      ),
    );
  }
}
