import 'package:digify_core/widgets/feedback/app_stepper_dialog.dart';
import 'package:digify_security_console/security_console/data/config/roles_management/duty_role_form_config.dart';

class DutyRoleStepperConfig {
  static List<StepperStepConfig> createSteps({required int functionCount, required int inheritedCount}) {
    return [
      StepperStepConfig(assetPath: DutyRoleFormConfig.basicInfoIconPath, label: DutyRoleFormConfig.stepLabels[0]),
      StepperStepConfig(assetPath: DutyRoleFormConfig.functionRolesIconPath, label: 'Function Roles ($functionCount)'),
      StepperStepConfig(
        assetPath: DutyRoleFormConfig.inheritedRolesIconPath,
        label: 'Inherited Roles${inheritedCount > 0 ? ' ($inheritedCount)' : ''}',
      ),
    ];
  }

  static List<StepperStepConfig> editSteps({required int functionCount, required int inheritedCount}) {
    return [
      StepperStepConfig(assetPath: DutyRoleFormConfig.basicInfoIconPath, label: DutyRoleFormConfig.stepLabels[0]),
      StepperStepConfig(assetPath: DutyRoleFormConfig.functionRolesIconPath, label: 'Function Roles ($functionCount)'),
      StepperStepConfig(
        assetPath: DutyRoleFormConfig.inheritedRolesIconPath,
        label: 'Inherited Roles${inheritedCount > 0 ? ' ($inheritedCount)' : ''}',
      ),
    ];
  }
}
