import 'package:digify_core/constants/app_colors.dart';
import 'package:digify_security_console/l10n/security_console_localizations.dart';
import 'package:digify_core/theme/app_shadows.dart';
import 'package:digify_core/theme/theme_extensions.dart';
import 'package:digify_core/widgets/common/digify_error_state.dart';
import 'package:digify_core/widgets/common/scrollable_wrapper.dart';
import 'package:digify_core/services/pagination_service.dart';
import 'package:digify_core/widgets/common/pagination_controls.dart';
import 'package:digify_core/models/pagination_info.dart';
import 'package:digify_security_console/security_console/workforce_bridge/domain/models/job_level.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/widgets/job_levels/job_level_row.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/widgets/job_levels/table/job_level_table_header.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/providers/job_level_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class JobLevelsTable extends ConsumerWidget {
  final List<JobLevel>? jobLevels;
  final PaginationState<JobLevel>? paginationState;
  final bool forceLoading;

  const JobLevelsTable({super.key, this.jobLevels, this.paginationState, this.forceLoading = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = context.isDark;
    final localizations = SecurityConsoleLocalizations.of(context)!;
    final providerState = ref.watch(jobLevelNotifierProvider);
    final effectiveState = paginationState ?? providerState;
    final levels = jobLevels ?? effectiveState.items;
    final isLoading = forceLoading || effectiveState.isLoading;

    if (!forceLoading && effectiveState.hasError && levels.isEmpty) {
      return DigifyErrorState(
        message: effectiveState.errorMessage ?? localizations.somethingWentWrong,
        onRetry: () => ref.read(jobLevelNotifierProvider.notifier).refresh(),
      );
    }

    if (!isLoading && levels.isEmpty) {
      return _JobLevelsEmptyState(localizations: localizations);
    }

    final tableRows = isLoading && levels.isEmpty ? _dummyJobLevels() : levels;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardBackgroundDark : AppColors.dashboardCard,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: AppShadows.primaryShadow,
      ),
      child: Column(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(minHeight: 500.h),
            child: ScrollableSingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Skeletonizer(
                enabled: isLoading,
                child: Column(
                  children: [
                    JobLevelTableHeader(isDark: isDark),
                    ...tableRows.map((level) => JobLevelRow(level: level)),
                  ],
                ),
              ),
            ),
          ),
          if (effectiveState.totalPages > 0) ...[
            PaginationControls.fromPaginationInfo(
              paginationInfo: PaginationInfo(
                currentPage: effectiveState.currentPage,
                totalPages: effectiveState.totalPages,
                totalItems: effectiveState.totalItems,
                pageSize: effectiveState.pageSize,
                hasNext: effectiveState.hasNextPage,
                hasPrevious: effectiveState.hasPreviousPage,
              ),
              currentPage: effectiveState.currentPage,
              pageSize: effectiveState.pageSize,
              onPrevious: effectiveState.hasPreviousPage
                  ? () => ref.read(jobLevelNotifierProvider.notifier).goToPage(effectiveState.currentPage - 1)
                  : null,
              onNext: effectiveState.hasNextPage
                  ? () => ref.read(jobLevelNotifierProvider.notifier).goToPage(effectiveState.currentPage + 1)
                  : null,
              isLoading: effectiveState.isLoading,
              style: PaginationStyle.simple,
            ),
          ],
        ],
      ),
    );
  }

  List<JobLevel> _dummyJobLevels() {
    return List.generate(
      6,
      (index) => JobLevel(
        id: index,
        nameEn: 'Job Level Name',
        code: 'LVL0${index + 1}',
        description: 'Description',
        minGradeId: 1,
        maxGradeId: 2,
        status: 'ACTIVE',
        totalPositions: 10,
        filledPositions: 5,
      ),
    );
  }
}

class _JobLevelsEmptyState extends StatelessWidget {
  const _JobLevelsEmptyState({required this.localizations});

  final SecurityConsoleLocalizations localizations;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 64.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.layers_outlined, size: 64.sp, color: AppColors.textSecondary),
            SizedBox(height: 16.h),
            Text(
              localizations.noResultsFound,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
            ),
          ],
        ),
      ),
    );
  }
}
