import 'package:flutter_riverpod/flutter_riverpod.dart';

class SecurityModuleEnterpriseNotifier extends StateNotifier<int?> {
  SecurityModuleEnterpriseNotifier() : super(null);

  bool get hasSelection => state != null;

  void setEnterpriseId(int? enterpriseId) {
    state = enterpriseId;
  }
}
