import 'package:digify_core/constants/app_colors.dart';
import 'package:digify_security_console/l10n/security_console_localizations.dart';
import 'package:digify_core/theme/theme_extensions.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/widgets/job_levels/job_level_form_dialog.dart';
import 'package:flutter/material.dart';
import 'package:digify_core/widgets/buttons/app_button.dart';
import 'package:digify_security_console/gen/assets.gen.dart';

class JobLevelsHeader extends StatelessWidget {
  const JobLevelsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = SecurityConsoleLocalizations.of(context)!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          localizations.jobLevels,
          style: context.textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w600, color: AppColors.textPrimary),
        ),
        AppButton.primary(
          svgPath: Assets.icons.addNewIconFigma.path,
          label: localizations.addJobFamily,
          onPressed: () => JobLevelFormDialog.show(context, onSave: (level) {}),
        ),
      ],
    );
  }
}
