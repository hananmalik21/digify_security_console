import 'package:digify_core/constants/app_colors.dart';
import 'package:digify_core/extensions/context_extensions.dart';
import 'package:digify_security_console/l10n/security_console_localizations.dart';
import 'package:digify_core/services/responsive_service.dart';
import 'package:digify_core/theme/theme_extensions.dart';
import 'package:digify_core/widgets/buttons/app_button.dart';
import 'package:digify_core/widgets/common/digify_bottom_sheet.dart';
import 'package:digify_core/widgets/feedback/app_dialog.dart';
import 'package:digify_security_console/security_console/workforce_bridge/domain/models/job_level.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/screens/job_levels/job_levels_permission_mixin.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/widgets/job_levels/job_level_detail_mobile_sheet.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/widgets/job_levels/job_level_form_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class JobLevelDetailDialog extends StatelessWidget with JobLevelsPermissionMixin {
  final JobLevel jobLevel;

  const JobLevelDetailDialog({super.key, required this.jobLevel});

  static Future<void> show(BuildContext context, JobLevel jobLevel) {
    if (context.isMobileLayout) {
      return DigifyBottomSheet.show<void>(
        context,
        type: DigifyBottomSheetType.custom,
        title: SecurityConsoleLocalizations.of(context)!.jobLevelDetails,
        child: JobLevelDetailMobileSheet(
          jobLevel: jobLevel,
          onEdit: () => JobLevelFormDialog.show(context, jobLevel: jobLevel, isEdit: true, onSave: (_) {}),
        ),
      );
    }

    return showDialog<void>(
      context: context,
      builder: (_) => JobLevelDetailDialog(jobLevel: jobLevel),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = SecurityConsoleLocalizations.of(context)!;

    return AppDialog(
      title: localizations.jobLevelDetails,
      width: 540.w,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: _buildField(context: context, label: localizations.levelName, value: jobLevel.nameEn),
              ),
              Gap(12.h),
              Flexible(
                child: _buildField(context: context, label: localizations.code, value: jobLevel.code),
              ),
            ],
          ),
          Gap(26.5.h),
          Align(
            alignment: AlignmentDirectional.topStart,
            child: _buildField(
              context: context,
              label: localizations.description,
              value: jobLevel.description,
              valueStyle: context.textTheme.titleSmall?.copyWith(fontSize: 15.sp, color: AppColors.textPrimary),
            ),
          ),
          Gap(30.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildField(
                context: context,
                label: localizations.minimumGrade,
                value: jobLevel.gradeRange.split('-').first.trim(),
              ),
              _buildField(
                context: context,
                label: localizations.maximumGrade,
                value: jobLevel.gradeRange.split('-').last.trim(),
              ),
              _buildField(context: context, label: localizations.totalPositions, value: '${jobLevel.totalPositions}'),
            ],
          ),
        ],
      ),
      actions: [
        AppButton.outline(label: localizations.close, onPressed: () => context.pop(), width: 100.w),
        if (canUpdateJobLevel) ...[
          Gap(12.w),
          AppButton.primary(
            label: localizations.edit,
            onPressed: () {
              JobLevelFormDialog.show(context, jobLevel: jobLevel, isEdit: true, onSave: (updated) {});
            },
            width: 100.w,
          ),
        ],
      ],
    );
  }

  Widget _buildField({
    required BuildContext context,
    required String label,
    required String value,
    TextStyle? valueStyle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: context.textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary)),
        Gap(4.h),
        Text(value, style: valueStyle ?? context.textTheme.titleMedium?.copyWith(color: AppColors.textPrimary)),
      ],
    );
  }
}
