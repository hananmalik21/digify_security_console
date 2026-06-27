import 'package:digify_core/constants/app_colors.dart';
import 'package:digify_core/theme/app_shadows.dart';
import 'package:digify_core/theme/theme_extensions.dart';
import 'package:digify_core/widgets/assets/digify_asset.dart';
import 'package:digify_core/widgets/common/pagination_controls.dart';
import 'package:digify_security_console/security_console/presentation/providers/security_alerts/security_alerts_state.dart';
import 'package:digify_security_console/security_console/presentation/widgets/security_alerts/security_alerts_activity_card.dart';
import 'package:digify_security_console/security_console/presentation/widgets/security_alerts/security_alerts_trends_card.dart';
import 'package:digify_security_console/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:digify_core/models/pagination_info.dart';

class SecurityAlertsActivitySection extends StatelessWidget {
  final bool isDark;
  final List<SecurityAlertItem> alerts;
  final VoidCallback onViewMatrix;

  const SecurityAlertsActivitySection({
    super.key,
    required this.isDark,
    required this.alerts,
    required this.onViewMatrix,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardBackgroundDark : AppColors.cardBackground,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: isDark ? AppColors.cardBorderDark : AppColors.cardBorder),
        boxShadow: AppShadows.primaryShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recent Alert Activity',
                      style: context.textTheme.titleLarge?.copyWith(
                        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Gap(4.h),
                    Text(
                      'Security events surfacing for review',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.tableHeaderBackground : AppColors.infoBg,
                  borderRadius: BorderRadius.circular(999.r),
                  border: Border.all(color: isDark ? AppColors.cardBorderDark : AppColors.infoBorder),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DigifyAsset(
                      assetPath: Assets.icons.refreshGray.path,
                      width: 12,
                      height: 12,
                      color: isDark ? AppColors.textSecondaryDark : AppColors.primary,
                    ),
                    Gap(5.w),
                    Text(
                      'Auto-refresh every 30 seconds',
                      style: context.textTheme.labelSmall?.copyWith(
                        color: isDark ? AppColors.textSecondaryDark : AppColors.primary,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Gap(16.h),
          if (alerts.isEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: Center(
                child: Text(
                  'No alerts match your filters.',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                  ),
                ),
              ),
            )
          else
            Column(
              children: [
                for (var i = 0; i < alerts.length; i++) ...[
                  SecurityAlertsActivityCard(alert: alerts[i], isDark: isDark),
                  if (i < alerts.length - 1) Gap(14.h),
                ],
              ],
            ),
          Gap(18.h),
          SecurityAlertsTrendsCard(isDark: isDark, onPressed: onViewMatrix),
          Gap(16.h),
          PaginationControls.fromPaginationInfo(
            paginationInfo: PaginationInfo(
              currentPage: 1,
              totalPages: 1,
              totalItems: alerts.length,
              pageSize: alerts.isEmpty ? 1 : alerts.length,
              hasNext: false,
              hasPrevious: false,
            ),
            currentPage: 1,
            pageSize: alerts.isEmpty ? 1 : alerts.length,
            onPrevious: null,
            onNext: null,
            style: PaginationStyle.simple,
          ),
        ],
      ),
    );
  }
}
