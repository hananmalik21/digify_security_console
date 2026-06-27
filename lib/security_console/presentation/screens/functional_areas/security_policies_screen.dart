import 'package:digify_core/constants/app_colors.dart';
import 'package:digify_core/services/toast_service.dart';
import 'package:digify_core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../providers/security_policies/security_policies_provider.dart';
import '../../providers/shared/security_manager_module_enterprise_providers.dart';
import 'security_policies/password_policies_section.dart';
import 'security_policies/session_auth_section.dart';
import 'security_policies/widgets/security_policies_header.dart';
import 'package:digify_enterprise_structure/digify_enterprise_structure.dart';

class SecurityPoliciesScreen extends ConsumerWidget {
  const SecurityPoliciesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(securityPoliciesProvider);
    final notifier = ref.read(securityPoliciesProvider.notifier);
    final values = state.values;
    final isDark = context.isDark;
    final effectiveEnterpriseId = ref.watch(securityPoliciesEnterpriseIdProvider);

    return Container(
      color: isDark ? AppColors.backgroundDark : AppColors.tableHeaderBackground,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 24.w).copyWith(bottom: 24.h),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 1100;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SecurityPoliciesHeader(
                  onSave: state.isDirty
                      ? () {
                          notifier.save();
                          ToastService.success(context, 'Security policies saved (placeholder).', title: 'Success');
                        }
                      : null,
                ),
                Gap(24.h),
                EnterpriseSelectorWidget(
                  selectedEnterpriseId: effectiveEnterpriseId,
                  onEnterpriseChanged: (enterpriseId) {
                    ref.read(securityPoliciesSelectedEnterpriseProvider.notifier).setEnterpriseId(enterpriseId);
                  },
                ),
                Gap(24.h),
                if (isWide)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: PasswordPoliciesSection(values: values, notifier: notifier),
                      ),
                      Gap(20.w),
                      Expanded(
                        child: SessionAuthSection(values: values, notifier: notifier),
                      ),
                    ],
                  )
                else
                  Column(
                    children: [
                      PasswordPoliciesSection(values: values, notifier: notifier),
                      Gap(20.h),
                      SessionAuthSection(values: values, notifier: notifier),
                    ],
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
