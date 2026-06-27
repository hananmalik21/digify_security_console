import 'package:digify_core/providers/current_user_provider.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/providers/workforce_enterprise_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final positionTreeSelectedEnterpriseProvider = StateNotifierProvider<WorkforceEnterpriseNotifier, int?>((ref) {
  final notifier = WorkforceEnterpriseNotifier();
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
});

final positionTreeEnterpriseIdProvider = Provider<int?>((ref) {
  final selected = ref.watch(positionTreeSelectedEnterpriseProvider);
  final active = ref.watch(activeEnterpriseIdProvider);
  return selected ?? active;
});
