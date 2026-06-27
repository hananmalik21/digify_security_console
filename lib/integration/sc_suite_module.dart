import 'package:digify_core/permissions/perm_module.dart';
import 'package:digify_core/router/feature_module.dart';
import 'package:digify_core/router/sidebar_tab_registry.dart';
import 'package:digify_security_console/security_console/domain/models/system_user.dart';
import 'package:digify_security_console/security_console/presentation/providers/application_roles/application_roles_state.dart';
import 'package:digify_security_console/security_console/presentation/providers/security_manager_tab_state_provider.dart';
import 'package:digify_security_console/security_console/presentation/screens/functional_areas/application_role_detail_screen.dart';
import 'package:digify_security_console/security_console/presentation/screens/security_manager_screen.dart';
import 'package:digify_security_console/security_console/presentation/screens/user_management/create_user_screen.dart';
import 'package:digify_security_console/security_console/presentation/screens/user_management/edit_user_screen.dart';
import 'package:digify_security_console/security_console/presentation/screens/user_management/user_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'sc_suite_permissions.dart';
import 'sc_suite_routes.dart';
import 'sc_suite_sidebar.dart';

class SecurityConsoleModule implements FeatureModule {
  const SecurityConsoleModule();

  @override
  String get id => 'securityManager';

  @override
  List<RouteBase> routes({GlobalKey<NavigatorState>? shellNavigatorKey}) => [
        GoRoute(
          path: SecurityConsoleRoutes.securityConsole,
          name: 'security-manager',
          builder: (context, state) => const SecurityManagerScreen(),
          routes: [
            GoRoute(
              path: 'user/add',
              name: CreateUserScreen.routeName,
              builder: (context, state) => const CreateUserScreen(),
            ),
            GoRoute(
              path: 'user/edit',
              name: EditUserScreen.routeName,
              builder: (context, state) {
                final user = state.extra is SystemUser ? state.extra! as SystemUser : null;
                if (user == null) {
                  return const Scaffold(body: Center(child: Text('User not found')));
                }
                return EditUserScreen(user: user);
              },
            ),
            GoRoute(
              path: 'user/show',
              name: UserDetailScreen.routeName,
              builder: (context, state) {
                final user = state.extra is SystemUser ? state.extra! as SystemUser : null;
                return UserDetailScreen(user: user);
              },
            ),
            GoRoute(
              path: 'application-role/detail',
              name: 'security-manager-application-role-detail',
              builder: (context, state) {
                final role = state.extra is ApplicationRoleItem ? state.extra! as ApplicationRoleItem : null;
                if (role == null) {
                  return const Scaffold(body: Center(child: Text('Role not found')));
                }
                return ApplicationRoleDetailScreen(role: role);
              },
            ),
          ],
        ),
      ];

  @override
  List<SidebarRegistration> sidebarItems() => securityConsoleSidebarItems();

  @override
  List<PermModule> permissionModules() => kSecurityConsolePermissionModules;

  @override
  void registerSidebarTabHandlers(SidebarTabRegistry registry) {
    registry.register(SecurityConsoleRoutes.securityConsole, const {
      'securityOverview': 0,
      'userManagement': 1,
      'accessManagement': 2,
      'rolesManagement': 3,
      'securityPolicies': 4,
      'activeSessions': 5,
      'securityAlerts': 6,
      'dataClassification': 7,
      'roleDelegation': 8,
      'segregationOfDuties': 9,
    });
  }

  static void applySidebarTab(WidgetRef ref, String route, String itemId) {
    if (route != SecurityConsoleRoutes.securityConsole) return;
    final index = _tabIndex(itemId);
    if (index == null) return;
    ref.read(securityManagerTabStateProvider.notifier).setTabIndex(index);
  }

  static int? _tabIndex(String itemId) {
    const handlers = {
      'securityOverview': 0,
      'userManagement': 1,
      'accessManagement': 2,
      'rolesManagement': 3,
      'securityPolicies': 4,
      'activeSessions': 5,
      'securityAlerts': 6,
      'dataClassification': 7,
      'roleDelegation': 8,
      'segregationOfDuties': 9,
    };
    return handlers[itemId];
  }
}
