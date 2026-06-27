import 'package:digify_core/widgets/assets/digify_asset_package_scope.dart';
import 'package:flutter/widgets.dart';

const String kSecurityConsoleAssetPackage = 'digify_security_console';

class SecurityConsoleAssetScope extends StatelessWidget {
  const SecurityConsoleAssetScope({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DigifyAssetPackageScope(package: kSecurityConsoleAssetPackage, child: child);
  }
}
