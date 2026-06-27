import 'package:digify_core/constants/app_colors.dart';
import 'package:digify_core/theme/theme_extensions.dart';
import 'package:digify_core/widgets/assets/digify_asset.dart';
import 'package:digify_core/widgets/common/digify_square_capsule.dart';
import 'package:digify_security_console/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class InheritedAssignmentListTile extends StatelessWidget {
  const InheritedAssignmentListTile({super.key, this.title, this.titleWidget, this.below, this.gapAfterLock = 10})
    : assert((title != null) ^ (titleWidget != null));

  final String? title;
  final Widget? titleWidget;
  final Widget? below;
  final double gapAfterLock;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final hasRichTitle = titleWidget != null;

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: isDark ? AppColors.inheritedAssignmentBgDark : AppColors.inheritedAssignmentBg,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: isDark ? AppColors.inheritedAssignmentBorderDark : AppColors.inheritedAssignmentBorder,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: hasRichTitle ? CrossAxisAlignment.start : CrossAxisAlignment.center,
            children: [
              Padding(
                padding: hasRichTitle ? EdgeInsets.only(top: 2.h) : EdgeInsets.zero,
                child: DigifyAsset(
                  assetPath: Assets.icons.lockIcon.path,
                  width: 18.sp,
                  height: 18.sp,
                  color: isDark ? AppColors.inheritedAssignmentAccentDark : AppColors.inheritedAssignmentAccent,
                ),
              ),
              Gap(gapAfterLock.w),
              Expanded(
                child:
                    titleWidget ??
                    Text(
                      title!,
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                    ),
              ),
              Padding(
                padding: hasRichTitle ? EdgeInsets.only(top: 2.h) : EdgeInsets.zero,
                child: DigifySquareCapsule(
                  label: 'Inherited',
                  backgroundColor: isDark ? AppColors.cardBackgroundDark : AppColors.cardBackground,
                  textColor: isDark
                      ? AppColors.inheritedAssignmentLabelTextDark
                      : AppColors.inheritedAssignmentLabelText,
                  borderColor: isDark ? AppColors.inheritedAssignmentBorderDark : AppColors.inheritedAssignmentBorder,
                ),
              ),
            ],
          ),
          ?below,
        ],
      ),
    );
  }
}
