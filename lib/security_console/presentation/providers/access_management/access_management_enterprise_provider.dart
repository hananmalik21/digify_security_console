import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:digify_core/providers/current_user_provider.dart';
import 'package:digify_security_console/security_console/presentation/providers/shared/security_module_enterprise_wiring.dart';
import 'access_management_provider.dart';

final accessManagementSelectedEnterpriseProvider =
    StateNotifierProvider<AccessManagementEnterpriseNotifier, int?>((ref) {
      final notifier = AccessManagementEnterpriseNotifier(ref);
      wireModuleEnterpriseSelectionFromHost(ref, notifier.setEnterpriseId);
      return notifier;
    });

class AccessManagementEnterpriseNotifier extends StateNotifier<int?> {
  final Ref ref;

  AccessManagementEnterpriseNotifier(this.ref) : super(null);

  bool get hasSelection => state != null;

  void setEnterpriseId(int? enterpriseId) {
    state = enterpriseId;
    if (enterpriseId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(accessManagementProvider.notifier)
            .setCompanyId(enterpriseId.toString());
      });
    }
  }
}

final accessManagementEnterpriseIdProvider = Provider<int?>((ref) {
  final selected = ref.watch(accessManagementSelectedEnterpriseProvider);
  final active = ref.watch(activeEnterpriseIdProvider);
  return selected ?? active;
});
