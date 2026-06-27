import 'package:digify_core/network/api_endpoints.dart';
import 'package:digify_security_console/l10n/security_console_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScSpreadsheetExportConfig {
  const ScSpreadsheetExportConfig({
    required this.endpoint,
    required this.queryParametersBuilder,
    required this.fileNameBuilder,
    required this.successMessage,
    required this.failureMessage,
  });

  final String endpoint;
  final Map<String, String> Function(int enterpriseId) queryParametersBuilder;
  final String Function(int enterpriseId) fileNameBuilder;
  final String successMessage;
  final String failureMessage;
}

class ScSpreadsheetExportConfigs {
  ScSpreadsheetExportConfigs._();

  static ScSpreadsheetExportConfig jobRoles(SecurityConsoleLocalizations localizations) {
    return ScSpreadsheetExportConfig(
      endpoint: ApiEndpoints.securityJobRolesExport,
      queryParametersBuilder: (enterpriseId) => {'enterprise_id': enterpriseId.toString()},
      fileNameBuilder: (enterpriseId) => 'job_roles_export_$enterpriseId.xlsx',
      successMessage: localizations.jobRolesExportSuccess,
      failureMessage: localizations.jobRolesExportFailed,
    );
  }

  static ScSpreadsheetExportConfig dataRoles(SecurityConsoleLocalizations localizations) {
    return ScSpreadsheetExportConfig(
      endpoint: ApiEndpoints.securityDataRolesExport,
      queryParametersBuilder: (enterpriseId) => {'enterprise_id': enterpriseId.toString()},
      fileNameBuilder: (enterpriseId) => 'data_roles_export_$enterpriseId.xlsx',
      successMessage: localizations.dataRolesExportSuccess,
      failureMessage: localizations.dataRolesExportFailed,
    );
  }

  static ScSpreadsheetExportConfig dutyRoles(SecurityConsoleLocalizations localizations) {
    return ScSpreadsheetExportConfig(
      endpoint: ApiEndpoints.securityDutyRolesExport,
      queryParametersBuilder: (enterpriseId) => {'enterprise_id': enterpriseId.toString()},
      fileNameBuilder: (enterpriseId) => 'duty_roles_export_$enterpriseId.xlsx',
      successMessage: localizations.dutyRolesExportSuccess,
      failureMessage: localizations.dutyRolesExportFailed,
    );
  }

  static ScSpreadsheetExportConfig functionRoles(SecurityConsoleLocalizations localizations) {
    return ScSpreadsheetExportConfig(
      endpoint: ApiEndpoints.securityFunctionRolesExport,
      queryParametersBuilder: (enterpriseId) => {'enterprise_id': enterpriseId.toString()},
      fileNameBuilder: (enterpriseId) => 'function_roles_export_$enterpriseId.xlsx',
      successMessage: localizations.functionRolesExportSuccess,
      failureMessage: localizations.functionRolesExportFailed,
    );
  }
}

class SpreadsheetExportNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  Future<void> export(
    BuildContext context, {
    required ScSpreadsheetExportConfig config,
    required int? enterpriseId,
  }) async {
  }
}

final spreadsheetExportProvider = NotifierProvider<SpreadsheetExportNotifier, bool>(SpreadsheetExportNotifier.new);
