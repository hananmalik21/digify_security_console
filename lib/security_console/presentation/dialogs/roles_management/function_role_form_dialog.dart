import 'package:digify_core/services/responsive/responsive_extensions.dart';
import 'package:digify_security_console/security_console/presentation/dialogs/roles_management/create_function_role_dialog.dart';
import 'package:digify_security_console/security_console/presentation/dialogs/roles_management/edit_function_role_dialog.dart';
import 'package:digify_security_console/security_console/presentation/providers/function_roles/function_roles_state.dart';
import 'package:digify_security_console/security_console/presentation/screens/functional_areas/function_role_form_mobile_sheet.dart';
import 'package:flutter/material.dart';

abstract final class FunctionRoleFormDialog {
  static Future<void> showCreate(BuildContext context) {
    if (context.isMobile) {
      return FunctionRoleFormMobileSheet.showCreate(context);
    }
    return CreateFunctionRoleDialog.show(context);
  }

  static Future<void> showEdit(BuildContext context, {required FunctionRoleItem role}) {
    if (context.isMobile) {
      return FunctionRoleFormMobileSheet.showEdit(context, role: role);
    }
    return EditFunctionRoleDialog.show(context, role: role);
  }
}
