import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:digify_core/providers/current_user_provider.dart';
import 'package:digify_security_console/security_console/presentation/providers/shared/security_module_enterprise_wiring.dart';
import 'user_management_enterprise_notifier.dart';

final userManagementSelectedEnterpriseProvider = StateNotifierProvider<UserManagementEnterpriseNotifier, int?>((ref) {
  final notifier = UserManagementEnterpriseNotifier(ref);
  wireModuleEnterpriseSelectionFromHost(ref, notifier.setEnterpriseId);
  return notifier;
});

final userManagementEnterpriseIdProvider = Provider<int?>((ref) {
  final selected = ref.watch(userManagementSelectedEnterpriseProvider);
  final active = ref.watch(activeEnterpriseIdProvider);
  return selected ?? active;
});
