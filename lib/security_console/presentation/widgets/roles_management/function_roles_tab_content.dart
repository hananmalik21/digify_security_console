import 'package:digify_security_console/integration/sc_spreadsheet_export_provider.dart';
import 'package:digify_security_console/l10n/security_console_localizations.dart';
import 'package:digify_security_console/integration/sc_spreadsheet_export_provider.dart';
import 'package:digify_core/services/responsive/responsive_extensions.dart';
import 'package:digify_security_console/security_console/presentation/providers/function_roles/function_roles_provider.dart';
import 'package:digify_security_console/security_console/presentation/providers/shared/security_manager_module_enterprise_providers.dart';
import 'package:digify_security_console/security_console/presentation/providers/security_modules/security_modules_provider.dart';
import 'package:digify_security_console/security_console/presentation/widgets/roles_management/function_roles/function_roles_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FunctionRolesTabContent extends ConsumerStatefulWidget {
  const FunctionRolesTabContent({super.key});

  @override
  ConsumerState<FunctionRolesTabContent> createState() => _FunctionRolesTabContentState();
}

class _FunctionRolesTabContentState extends ConsumerState<FunctionRolesTabContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(functionRolesProvider.notifier).refresh();
      ref.read(securityModulesProvider.notifier).load();
    });
  }

  void _onExport(SecurityConsoleLocalizations localizations) {
    final enterpriseId = ref.read(rolesManagementEnterpriseIdProvider);
    ref
        .read(spreadsheetExportProvider.notifier)
        .export(context, enterpriseId: enterpriseId, config: ScSpreadsheetExportConfigs.functionRoles(localizations));
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<int?>(rolesManagementEnterpriseIdProvider, (previous, next) {
      if (previous != next) {
        ref.read(functionRolesProvider.notifier).refresh();
        ref.read(securityModulesProvider.notifier).load();
      }
    });

    final isMobile = context.isMobile;
    final localizations = SecurityConsoleLocalizations.of(context)!;
    final isExporting = ref.watch(spreadsheetExportProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 20.h,
      children: [
        const FunctionRolesStatsRow(),
        if (isMobile) const FunctionRolesSearchCardMobile() else const FunctionRolesSearchCard(),
        if (isMobile)
          FunctionRolesDirectorySectionMobile(onExport: () => _onExport(localizations), isExporting: isExporting)
        else
          FunctionRolesDirectorySection(onExport: () => _onExport(localizations), isExporting: isExporting),
      ],
    );
  }
}
