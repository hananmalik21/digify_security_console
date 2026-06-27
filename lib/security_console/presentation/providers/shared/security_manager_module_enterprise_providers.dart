import 'package:digify_core/providers/current_user_provider.dart';
import 'package:digify_security_console/security_console/presentation/providers/shared/security_module_enterprise_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

SecurityModuleEnterpriseNotifier _createSecurityModuleEnterpriseNotifier(Ref ref) {
  final notifier = SecurityModuleEnterpriseNotifier();
  final initialActive = ref.read(activeEnterpriseIdProvider);
  if (initialActive != null) {
    notifier.setEnterpriseId(initialActive);
  }
  ref.listen<int?>(activeEnterpriseIdProvider, (previous, next) {
    if (next != null && !notifier.hasSelection) {
      notifier.setEnterpriseId(next);
    }
  });
  return notifier;
}

Provider<int?> _enterpriseIdProvider(
  StateNotifierProvider<SecurityModuleEnterpriseNotifier, int?> selectedProvider,
) {
  return Provider<int?>((ref) {
    final selected = ref.watch(selectedProvider);
    final active = ref.watch(activeEnterpriseIdProvider);
    return selected ?? active;
  });
}

final securityOverviewSelectedEnterpriseProvider =
    StateNotifierProvider<SecurityModuleEnterpriseNotifier, int?>((ref) {
  return _createSecurityModuleEnterpriseNotifier(ref);
});

final securityOverviewEnterpriseIdProvider = _enterpriseIdProvider(
  securityOverviewSelectedEnterpriseProvider,
);

final rolesManagementSelectedEnterpriseProvider =
    StateNotifierProvider<SecurityModuleEnterpriseNotifier, int?>((ref) {
  return _createSecurityModuleEnterpriseNotifier(ref);
});

final rolesManagementEnterpriseIdProvider = _enterpriseIdProvider(
  rolesManagementSelectedEnterpriseProvider,
);

final securityPoliciesSelectedEnterpriseProvider =
    StateNotifierProvider<SecurityModuleEnterpriseNotifier, int?>((ref) {
  return _createSecurityModuleEnterpriseNotifier(ref);
});

final securityPoliciesEnterpriseIdProvider = _enterpriseIdProvider(
  securityPoliciesSelectedEnterpriseProvider,
);

final activeSessionsSelectedEnterpriseProvider =
    StateNotifierProvider<SecurityModuleEnterpriseNotifier, int?>((ref) {
  return _createSecurityModuleEnterpriseNotifier(ref);
});

final activeSessionsEnterpriseIdProvider = _enterpriseIdProvider(
  activeSessionsSelectedEnterpriseProvider,
);

final securityAlertsSelectedEnterpriseProvider =
    StateNotifierProvider<SecurityModuleEnterpriseNotifier, int?>((ref) {
  return _createSecurityModuleEnterpriseNotifier(ref);
});

final securityAlertsEnterpriseIdProvider = _enterpriseIdProvider(
  securityAlertsSelectedEnterpriseProvider,
);
