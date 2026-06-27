import 'package:digify_security_console/l10n/security_console_localizations.dart';
import 'package:digify_core/services/toast_service.dart';
import 'package:digify_core/widgets/buttons/app_button.dart';
import 'package:digify_core/widgets/common/digify_tab_header.dart';
import 'package:digify_core/widgets/feedback/app_confirmation_dialog.dart';
import 'package:digify_security_console/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class ActiveSessionsHeader extends StatelessWidget {
  const ActiveSessionsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = SecurityConsoleLocalizations.of(context)!;
    return DigifyTabHeader(
      title: localizations.activeSessions,
      description: 'Monitor and manage user sessions in real-time',
      trailing: AppButton.danger(
        label: 'Force Logout All',
        svgPath: Assets.icons.securityManager.terminate.path,
        onPressed: () async {
          final confirmed = await AppConfirmationDialog.show(
            context,
            title: 'Force logout all sessions?',
            message: 'This will sign out all users from all devices. You can’t undo this action.',
            confirmLabel: 'Force logout',
            type: ConfirmationType.danger,
            svgPath: Assets.icons.securityManager.terminate.path,
          );
          if (confirmed == true && context.mounted) {
            ToastService.warning(context, 'Terminate all sessions (mock).', title: localizations.activeSessions);
          }
        },
      ),
    );
  }
}
