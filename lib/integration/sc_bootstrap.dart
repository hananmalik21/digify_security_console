import 'package:digify_core/providers/current_user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

export 'package:digify_core/providers/current_user_provider.dart'
    show activeEnterpriseIdProvider, enterprisesCacheProvider;

final suiteActiveEnterpriseIdProvider = StateProvider<int?>((ref) => null);

final suiteEnterprisesCacheProvider = StateProvider<List<dynamic>>((ref) => const []);

List<Override> get securityConsoleProviderOverrides => [
      activeEnterpriseIdProvider.overrideWith((ref) => ref.watch(suiteActiveEnterpriseIdProvider)),
      enterprisesCacheProvider.overrideWith((ref) => ref.watch(suiteEnterprisesCacheProvider)),
    ];

void setActiveEnterpriseId(WidgetRef ref, int? enterpriseId) {
  ref.read(suiteActiveEnterpriseIdProvider.notifier).state = enterpriseId;
}
