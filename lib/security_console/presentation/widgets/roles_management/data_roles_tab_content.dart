import 'package:digify_security_console/integration/sc_spreadsheet_export_provider.dart';
import 'package:digify_security_console/l10n/security_console_localizations.dart';
import 'package:digify_security_console/integration/sc_spreadsheet_export_provider.dart';
import 'package:digify_core/services/responsive/responsive_extensions.dart';
import 'package:digify_security_console/security_console/presentation/providers/data_roles/data_roles_provider.dart';
import 'package:digify_security_console/security_console/domain/models/security_lookup_value.dart';
import 'package:digify_security_console/security_console/presentation/providers/shared/security_manager_module_enterprise_providers.dart';
import 'package:digify_security_console/security_console/presentation/providers/security_lookups/security_lookups_provider.dart';
import 'package:digify_security_console/security_console/presentation/widgets/roles_management/data_roles/data_roles_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DataRolesTabContent extends ConsumerStatefulWidget {
  const DataRolesTabContent({super.key});

  @override
  ConsumerState<DataRolesTabContent> createState() => _DataRolesTabContentState();
}

class _DataRolesTabContentState extends ConsumerState<DataRolesTabContent> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: ref.read(dataRolesProvider).searchQuery);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(dataRolesProvider.notifier).refresh();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onExport(SecurityConsoleLocalizations localizations) {
    final enterpriseId = ref.read(rolesManagementEnterpriseIdProvider);
    ref
        .read(spreadsheetExportProvider.notifier)
        .export(context, enterpriseId: enterpriseId, config: ScSpreadsheetExportConfigs.dataRoles(localizations));
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<int?>(rolesManagementEnterpriseIdProvider, (previous, next) {
      if (previous != next && next != null) {
        ref.read(dataRolesProvider.notifier).refresh();
      }
    });

    final isMobile = context.isMobile;
    final state = ref.watch(dataRolesProvider);
    final notifier = ref.read(dataRolesProvider.notifier);
    final enterpriseId = ref.watch(rolesManagementEnterpriseIdProvider);
    final localizations = SecurityConsoleLocalizations.of(context)!;
    final isExporting = ref.watch(spreadsheetExportProvider);
    final AsyncValue<List<SecurityLookupValue>> dataTypesAsync = enterpriseId == null
        ? const AsyncValue<List<SecurityLookupValue>>.data([])
        : ref.watch(dataRoleDataTypeLookupValuesProvider(enterpriseId));
    final dataTypes = dataTypesAsync.valueOrNull ?? const <SecurityLookupValue>[];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 20.h,
      children: [
        DataRolesStatsRow(totalRoles: state.totalItems, activeRoles: state.roles.where((r) => r.isActive).length),
        DataRolesSearchCard(
          searchController: _searchController,
          selectedDataType: state.selectedDataTypeLookup(dataTypes),
          dataTypeOptions: dataTypes,
          dataTypesLoading: dataTypesAsync.isLoading,
          onSearchChanged: notifier.updateSearch,
          onDataTypeChanged: notifier.updateDataType,
        ),
        if (isMobile)
          DataRolesDirectorySectionMobile(onExport: () => _onExport(localizations), isExporting: isExporting)
        else
          DataRolesDirectorySection(
            state: state,
            onPrevious: notifier.previousPage,
            onNext: notifier.nextPage,
            onPageTap: notifier.goToPage,
            onExport: () => _onExport(localizations),
            isExporting: isExporting,
          ),
      ],
    );
  }
}
