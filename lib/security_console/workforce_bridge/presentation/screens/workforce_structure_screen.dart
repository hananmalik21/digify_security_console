import 'package:digify_core/constants/app_colors.dart';
import 'package:digify_security_console/l10n/security_console_localizations.dart';
import 'package:digify_core/router/app_routes.dart';
import 'package:digify_core/router/breadcrumb_nav_extra.dart';
import 'package:digify_core/services/responsive_service.dart';
import 'package:digify_core/theme/theme_extensions.dart';
import 'package:digify_core/widgets/common/digify_breadcrumb.dart';
import 'package:digify_core/widgets/feedback/placeholder_screen.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/widgets/common/workforce_tab_config.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/providers/workforce_tab_provider.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/widgets/grade_structure/grade_structure_tab.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/widgets/job_families/job_families_tab.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/widgets/job_levels/job_levels_tab.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/widgets/positions/positions_tab.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/widgets/reporting_structure/reporting_structure_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class WorkforceStructureScreen extends ConsumerWidget {
  const WorkforceStructureScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = SecurityConsoleLocalizations.of(context)!;
    final isDark = context.isDark;
    final currentTabIndex = ref.watch(workforceTabStateProvider.select((s) => s.currentTabIndex));
    final isMobile = ResponsiveHelper.isMobile(context);
    final tabs = WorkforceTab.values;
    final currentTab = (currentTabIndex >= 0 && currentTabIndex < tabs.length)
        ? tabs[currentTabIndex]
        : WorkforceTab.positions;
    final headerTitle = currentTab.label(localizations);
    final extra = GoRouterState.of(context).extra;
    final BreadcrumbNavExtra? navExtra = extra is BreadcrumbNavExtra ? extra : null;
    final moduleSelectionRoute = navExtra?.returnTo ?? AppRoutes.dashboardModuleSelectionPath('workforceStructure');
    final moduleSelectionLabel = navExtra?.returnLabel ?? 'Module Selection';

    return Container(
      color: isDark ? AppColors.backgroundDark : AppColors.tableHeaderBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: ResponsiveHelper.getPagePadding(context),
            child: isMobile
                ? null
                : DigifyBreadcrumb(
                    items: [
                      DigifyBreadcrumbItem(label: 'Dashboard', onTap: () => context.go(AppRoutes.dashboard)),
                      const DigifyBreadcrumbItem(label: 'Workforce Structure'),
                      DigifyBreadcrumbItem(label: moduleSelectionLabel, onTap: () => context.go(moduleSelectionRoute)),
                      DigifyBreadcrumbItem(label: headerTitle),
                    ],
                  ),
          ),
          if (!isMobile) Gap(24.h),
          Expanded(child: _buildTabWidget(context, currentTabIndex)),
        ],
      ),
    );
  }

  Widget _buildTabWidget(BuildContext context, int tabIndex) {
    switch (tabIndex) {
      case 0:
        return const PositionsTab();
      case 1:
        return const JobFamiliesTab();
      case 2:
        return const JobLevelsTab();
      case 3:
        return const GradeStructureTab();
      case 4:
        return const ReportingStructureTab();
      case 5:
        return PlaceholderScreen(title: 'Position Tree');
      default:
        return const PositionsTab();
    }
  }
}
