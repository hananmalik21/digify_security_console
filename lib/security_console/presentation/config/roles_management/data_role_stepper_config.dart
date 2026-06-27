import 'package:digify_core/widgets/feedback/app_stepper_dialog.dart';
import 'package:digify_security_console/security_console/data/config/roles_management/data_role_form_config.dart';

class DataRoleStepperConfig {
  static List<StepperStepConfig> steps() {
    return [
      StepperStepConfig(assetPath: DataRoleFormConfig.tabsSettingsIconPath, label: 'Basic Information'),
      StepperStepConfig(assetPath: DataRoleFormConfig.tabsBusinessUnitIconPath, label: 'Workforce Structure'),
      StepperStepConfig(assetPath: DataRoleFormConfig.tabsCompanyIconPath, label: 'Enterprise Structure'),
    ];
  }
}
