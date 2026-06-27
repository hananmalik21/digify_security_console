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

class NotificationPreferencesSection extends ConsumerWidget {
  const NotificationPreferencesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(userFormProvider);
    final notifier = ref.read(userFormProvider.notifier);

    return UserFormSection(
      isDark: context.isDark,
      header: SectionHeaderCard(title: 'Notification Preferences', iconAssetPath: Assets.icons.notificationsIcon.path),
      child: Column(
        children: [
          PreferenceToggleTile(
            title: 'Email Notifications',
            subtitle: 'Receive notifications via email',
            value: state.receiveEmailNotifications ?? false,
            onChanged: notifier.setReceiveEmailNotifications,
          ),
          Gap(12.h),
          PreferenceToggleTile(
            title: 'SMS Notifications',
            subtitle: 'Receive important alerts via SMS',
            value: state.receiveSmsNotifications ?? false,
            onChanged: notifier.setReceiveSmsNotifications,
          ),
          Gap(12.h),
          PreferenceToggleTile(
            title: 'In-App Notifications',
            subtitle: 'Show notifications within the application',
            value: state.receivePushNotifications ?? false,
            onChanged: notifier.setReceivePushNotifications,
          ),
          Gap(12.h),
          PreferenceToggleTile(
            title: 'Workflow Alerts',
            subtitle: 'Notifications for approvals and workflow items',
            value: state.allowWorkflowAlerts ?? false,
            onChanged: notifier.setAllowWorkflowAlerts,
          ),
        ],
      ),
    );
  }
}
