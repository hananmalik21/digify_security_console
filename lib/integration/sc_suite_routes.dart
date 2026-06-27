/// Route constants used inside the security console package.
abstract final class SecurityConsoleRoutes {
  static const String dashboard = '/dashboard';
  static const String dashboardModuleSelection = '$dashboard/module-selection';
  static String dashboardModuleSelectionPath(String moduleId) => '$dashboardModuleSelection/$moduleId';

  static const String securityConsole = '/security-console';
  static const String securityConsoleUserShow = '$securityConsole/user/show';
}
