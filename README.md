# Digify Security Console

Standalone Flutter package for **Security Manager / Security Console** — extracted from Digify HR.

## Packages

| Package | Description |
|---------|-------------|
| `digify_security_console` | Security module (overview, users, access, roles, policies, sessions, alerts, data classification, delegation, SoD) |
| `digify_core` | Shared theme, network, widgets, router contracts |
| `digify_enterprise_structure` | Enterprise selector widgets and org structure |

## Git setup

```yaml
dependencies:
  digify_security_console:
    git:
      url: https://github.com/hananmalik21/digify_security_console.git
      ref: main
  digify_core:
    git:
      url: https://github.com/hananmalik21/digify_core.git
      ref: main
  digify_enterprise_structure:
    git:
      url: https://github.com/hananmalik21/digify_enterprise_structure.git
      ref: main
```

Local path development:

```yaml
dependencies:
  digify_security_console:
    path: ../digify_security_console
```

## Host integration

```dart
import 'package:digify_security_console/digify_security_console.dart';
import 'package:digify_core/providers/current_user_provider.dart';

ProviderScope(
  overrides: [
    ...buildSecurityConsoleHostOverrides(),
    activeEnterpriseIdProvider.overrideWith((ref) => ref.watch(yourActiveEnterpriseIdProvider)),
  ],
  child: MyApp(),
);

// Router
...const SecurityConsoleModule().routes(),

// Localization
localizationsDelegates: [
  ...AppLocalizations.localizationsDelegates,
  SecurityConsoleLocalizations.delegate,
],

// Assets when showing security screens
SecurityConsoleAssetScope(child: child),
```

The host owns **enterprise context**, **auth/API**, and **permissions**. Security Console reads `activeEnterpriseIdProvider` from `digify_core`.

## Code generation

```bash
fvm flutter pub get
fvm dart run build_runner build
fvm flutter gen-l10n
```

## Analyze

```bash
fvm flutter analyze
```
