import 'package:digify_security_console/l10n/security_console_localizations.dart';
import 'package:digify_core/services/responsive/responsive_extensions.dart';
import 'package:digify_core/theme/theme_extensions.dart';
import 'package:digify_core/widgets/assets/digify_asset_button.dart';
import 'package:digify_security_console/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import 'package:digify_core/constants/app_colors.dart';
import 'package:digify_security_console/security_console/domain/models/user_detail_data.dart';

class UserDetailHeaderSection extends StatelessWidget {
  final UserDetailData detail;

  const UserDetailHeaderSection({super.key, required this.detail});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final localizations = SecurityConsoleLocalizations.of(context)!;
    final isCompact =
        context.isMobile || (context.responsiveData.isTablet && context.isPortrait);

    final titleSection = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          localizations.accountDetails,
          style: context.textTheme.titleLarge?.copyWith(
            fontSize: 24.sp,
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
          ),
        ),
        Gap(4.h),
        Text(
          detail.displayFullName,
          style: TextStyle(
            fontSize: 12.sp,
            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
          ),
        ),
      ],
    );

    if (isCompact) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DigifyAssetButton(
                onTap: () => context.pop(),
                assetPath: Assets.icons.employeeManagement.backArrow.path,
              ),
              Gap(16.w),
              Expanded(child: titleSection),
            ],
          ),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DigifyAssetButton(
          onTap: () => context.pop(),
          assetPath: Assets.icons.employeeManagement.backArrow.path,
        ),
        Gap(24.w),
        Expanded(child: titleSection),
      ],
    );
  }
}
