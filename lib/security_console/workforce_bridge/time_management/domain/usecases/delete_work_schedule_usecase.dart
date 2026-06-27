import 'package:digify_security_console/security_console/workforce_bridge/time_management/domain/repositories/work_schedule_repository.dart';

class DeleteWorkScheduleUseCase {
  final WorkScheduleRepository repository;

  const DeleteWorkScheduleUseCase({required this.repository});

  Future<void> call({required int scheduleId, bool hard = true}) async {
    return await repository.deleteWorkSchedule(scheduleId: scheduleId, hard: hard);
  }
}
