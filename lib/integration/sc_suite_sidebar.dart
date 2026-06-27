import 'package:digify_core/router/feature_module.dart';

import 'sc_suite_routes.dart';

List<SidebarRegistration> securityConsoleSidebarItems() => [
      const SidebarRegistration(
        id: 'securityManager',
        labelKey: 'securityManager',
        route: SecurityConsoleRoutes.securityConsole,
        subtitle: 'Comprehensive Security and Access Control',
        svgPath: 'assets/icons/security_manager/application-roles.svg',
        children: [
          SidebarRegistration(
            id: 'securityOverview',
            labelKey: 'securityOverview',
            route: SecurityConsoleRoutes.securityConsole,
            svgPath: 'assets/icons/security_manager/application-roles.svg',
          ),
          SidebarRegistration(
            id: 'userManagement',
            labelKey: 'userManagement',
            route: SecurityConsoleRoutes.securityConsole,
            svgPath: 'assets/icons/security_manager/add-user.svg',
          ),
          SidebarRegistration(
            id: 'accessManagement',
            labelKey: 'accessManagement',
            route: SecurityConsoleRoutes.securityConsole,
            svgPath: 'assets/icons/security_manager/database.svg',
          ),
          SidebarRegistration(
            id: 'rolesManagement',
            labelKey: 'rolesManagement',
            route: SecurityConsoleRoutes.securityConsole,
            svgPath: 'assets/icons/security_manager/application-roles.svg',
          ),
          SidebarRegistration(
            id: 'securityPolicies',
            labelKey: 'securityPolicies',
            route: SecurityConsoleRoutes.securityConsole,
            svgPath: 'assets/icons/security_manager/database.svg',
          ),
          SidebarRegistration(
            id: 'activeSessions',
            labelKey: 'activeSessions',
            route: SecurityConsoleRoutes.securityConsole,
            svgPath: 'assets/icons/security_manager/active-session.svg',
          ),
          SidebarRegistration(
            id: 'securityAlerts',
            labelKey: 'securityAlerts',
            route: SecurityConsoleRoutes.securityConsole,
            svgPath: 'assets/icons/security_manager/security-alerts.svg',
          ),
          SidebarRegistration(
            id: 'dataClassification',
            labelKey: 'dataClassification',
            route: SecurityConsoleRoutes.securityConsole,
            svgPath: 'assets/icons/security_manager/data-classification.svg',
          ),
          SidebarRegistration(
            id: 'roleDelegation',
            labelKey: 'roleDelegation',
            route: SecurityConsoleRoutes.securityConsole,
            svgPath: 'assets/icons/security_manager/role-delegation.svg',
          ),
          SidebarRegistration(
            id: 'segregationOfDuties',
            labelKey: 'segregationOfDuties',
            route: SecurityConsoleRoutes.securityConsole,
            svgPath: 'assets/icons/security_manager/segregation.svg',
          ),
        ],
      ),
    ];
