import 'package:digify_security_console/l10n/security_console_localizations.dart';
import 'package:digify_core/widgets/buttons/app_button.dart';
import 'package:digify_core/widgets/common/digify_tab_header.dart';
import 'package:digify_security_console/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class SecurityPoliciesHeader extends StatelessWidget {
  final VoidCallback? onSave;

  const SecurityPoliciesHeader({super.key, required this.onSave});

  @override
  Widget build(BuildContext context) {
    final localizations = SecurityConsoleLocalizations.of(context)!;
    return DigifyTabHeader(
      title: localizations.securityPolicies,
      description: 'Configure system-wide security rules and requirements',
      trailing: AppButton.primary(
        label: localizations.saveChanges,
        svgPath: Assets.icons.saveDivisionIcon.path,
        onPressed: onSave,
      ),
    );
  }
}
