import 'package:digify_core/providers/current_user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


void wireModuleEnterpriseSelectionFromHost(
  Ref ref,
  void Function(int? enterpriseId) setEnterpriseId,
) {
  final initialActive = ref.read(activeEnterpriseIdProvider);
  if (initialActive != null) {
    setEnterpriseId(initialActive);
  }
  ref.listen<int?>(activeEnterpriseIdProvider, (previous, next) {
    if (previous != next) {
      setEnterpriseId(next);
    }
  });
}
