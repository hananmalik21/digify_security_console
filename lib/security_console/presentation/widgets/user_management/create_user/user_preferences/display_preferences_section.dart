import 'package:digify_core/theme/theme_extensions.dart';
import 'package:digify_core/widgets/common/section_header_card.dart';
import 'package:digify_security_console/security_console/presentation/providers/user_management/user_form_provider.dart';
import 'package:digify_security_console/security_console/presentation/widgets/user_management/create_user/user_preferences/preference_toggle_tile.dart';
import 'package:digify_security_console/security_console/presentation/widgets/user_management/user_form_section.dart';
import 'package:digify_security_console/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class DisplayPreferencesSection extends ConsumerWidget {
  const DisplayPreferencesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(userFormProvider);
    final notifier = ref.read(userFormProvider.notifier);

    return UserFormSection(
      isDark: context.isDark,
      header: SectionHeaderCard(title: 'Display Preferences', iconAssetPath: Assets.icons.settingsIcon.path),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PreferenceToggleTile(
            title: 'Compact View',
            subtitle: 'Use compact mode for tables and lists',
            value: state.compactView ?? false,
            onChanged: notifier.setCompactView,
          ),
          Gap(12.h),
          PreferenceToggleTile(
            title: 'Show Tooltips',
            subtitle: 'Display helpful tooltips throughout the system',
            value: state.showTooltips ?? false,
            onChanged: notifier.setShowTooltips,
          ),
        ],
      ),
    );
  }
}
