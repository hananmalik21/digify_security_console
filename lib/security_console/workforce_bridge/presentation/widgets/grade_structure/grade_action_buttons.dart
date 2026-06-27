import 'package:digify_core/services/toast_service.dart';
import 'package:digify_core/widgets/buttons/action_button_widget.dart';
import 'package:digify_core/widgets/feedback/app_confirmation_dialog.dart';
import 'package:digify_security_console/security_console/workforce_bridge/domain/models/grade.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/providers/grade_providers.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/screens/grade_structure/grade_structure_permission_mixin.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/widgets/grade_structure/update_grade_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class GradeActionButtons extends ConsumerWidget with GradeStructurePermissionMixin {
  final Grade grade;

  const GradeActionButtons({super.key, required this.grade});

  Future<void> _handleDelete(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(gradeNotifierProvider.notifier).deleteGrade(grade.id);
      if (context.mounted) {
        ToastService.success(context, 'Grade deleted successfully');
      }
    } catch (e) {
      if (context.mounted) {
        ToastService.error(context, 'Error deleting grade');
      }
    }
  }

  void _handleEdit(BuildContext context) {
    UpdateGradeDialog.show(context, grade: grade);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deletingGradeId = ref.watch(gradeNotifierProvider).deletingGradeId;
    final isDeleting = deletingGradeId == grade.id;

    return Row(
      children: [
        if (canUpdateGrade)
          ActionButtonWidget(
            type: ActionButtonType.edit,
            height: 28.w,
            width: 28.w,
            onTap: isDeleting ? null : () => _handleEdit(context),
          ),
        if (canDeleteGrade) ...[
          Gap(4.w),
          ActionButtonWidget(
            type: ActionButtonType.delete,
            height: 28.w,
            width: 28.w,
            isLoading: isDeleting,
            onTap: () async {
              final confirmed = await AppConfirmationDialog.show(
                context,
                title: 'Delete Grade',
                message: 'Are you sure you want to delete this grade? This action cannot be undone.',
                itemName: grade.gradeLabel,
                confirmLabel: 'Delete',
                cancelLabel: 'Cancel',
                type: ConfirmationType.danger,
              );
              if (confirmed == true && context.mounted) {
                await _handleDelete(context, ref);
              }
            },
          ),
        ],
      ],
    );
  }
}
