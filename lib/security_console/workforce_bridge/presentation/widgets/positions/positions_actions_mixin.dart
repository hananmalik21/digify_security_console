import 'package:digify_security_console/l10n/security_console_localizations.dart';
import 'package:digify_core/services/responsive_service.dart';
import 'package:digify_core/services/toast_service.dart';
import 'package:digify_core/widgets/common/digify_bottom_sheet.dart';
import 'package:digify_core/widgets/feedback/app_confirmation_dialog.dart';
import 'package:digify_security_console/security_console/workforce_bridge/domain/models/position.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/providers/position_providers.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/widgets/positions/position_details_dialog.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/widgets/positions/position_details_mobile_sheet.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/widgets/positions/position_form_dialog.dart';
import 'package:digify_security_console/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin PositionsActionsMixin<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  void showPositionDetailsDialog(BuildContext context, Position position) {
    if (context.isMobileLayout) {
      DigifyBottomSheet.show<void>(
        context,
        type: DigifyBottomSheetType.custom,
        title: SecurityConsoleLocalizations.of(context)!.positionDetails,
        child: PositionDetailsMobileSheet(
          position: position,
          onEdit: () => showPositionFormDialog(context, position, true),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => PositionDetailsDialog(position: position),
    );
  }

  void showPositionFormDialog(BuildContext context, Position position, bool isEdit) {
    PositionFormDialog.show(context, position: position, isEdit: isEdit);
  }

  Future<void> showDeleteConfirmation(Position position) async {
    if (!mounted) return;
    final localizations = SecurityConsoleLocalizations.of(context)!;
    final confirmed = await AppConfirmationDialog.show(
      context,
      title: localizations.delete,
      message: 'Are you sure you want to delete this position? This action cannot be undone.',
      itemName: position.titleEnglish,
      confirmLabel: localizations.delete,
      cancelLabel: localizations.cancel,
      type: ConfirmationType.danger,
      svgPath: Assets.icons.deleteIconRed.path,
    );
    if (confirmed != true || !mounted) return;
    try {
      await ref.read(positionNotifierProvider.notifier).deletePosition(position.id);
      if (!mounted) return;
      ToastService.success(context, 'Position deleted successfully', title: 'Deleted');
    } catch (e) {
      if (!mounted) return;
      ToastService.error(context, 'Failed to delete position: ${e.toString()}', title: 'Error');
    }
  }
}
