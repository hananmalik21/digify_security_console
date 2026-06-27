import 'package:digify_core/widgets/common/app_unauthorized_state.dart';
import 'package:digify_core/services/responsive_service.dart';
import 'package:digify_security_console/security_console/presentation/screens/functional_areas/roles_management_permission_mixin.dart';
import 'package:digify_security_console/security_console/presentation/providers/shared/security_manager_module_enterprise_providers.dart';
import 'package:digify_security_console/security_console/presentation/screens/functional_areas/roles_management_desktop_layout.dart';
import 'package:digify_security_console/security_console/presentation/screens/functional_areas/roles_management_mobile_layout.dart';
import 'package:digify_security_console/security_console/presentation/screens/functional_areas/roles_management_tablet_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RolesManagementScreen extends ConsumerStatefulWidget {
  const RolesManagementScreen({super.key});

  @override
  ConsumerState<RolesManagementScreen> createState() => _RolesManagementScreenState();
}

class _RolesManagementScreenState extends ConsumerState<RolesManagementScreen> with RolesManagementPermissionMixin {
  void _onEnterpriseChanged(int? enterpriseId) {
    ref.read(rolesManagementSelectedEnterpriseProvider.notifier).setEnterpriseId(enterpriseId);
  }

  @override
  Widget build(BuildContext context) {
    final selectedEnterpriseId = ref.watch(rolesManagementEnterpriseIdProvider);
    final layout = context.screenLayout;

    if (!canViewRole) return AppUnauthorizedState();

    if (layout.isMobile) {
      return RolesManagementMobileLayout(
        selectedEnterpriseId: selectedEnterpriseId,
        onEnterpriseChanged: _onEnterpriseChanged,
      );
    }

    if (layout.isTablet) {
      return RolesManagementTabletLayout(
        selectedEnterpriseId: selectedEnterpriseId,
        onEnterpriseChanged: _onEnterpriseChanged,
      );
    }

    return RolesManagementDesktopLayout(
      selectedEnterpriseId: selectedEnterpriseId,
      onEnterpriseChanged: _onEnterpriseChanged,
    );
  }
}
