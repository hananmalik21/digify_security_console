import 'package:digify_security_console/l10n/security_console_localizations.dart';
import 'package:digify_core/widgets/common/digify_error_state.dart';
import 'package:digify_core/widgets/common/pagination_controls.dart';
import 'package:digify_core/models/pagination_info.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/providers/job_family_providers.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/providers/job_level_providers.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/widgets/job_families/components/job_family_empty_state.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/widgets/job_families/components/job_family_skeleton.dart';
import 'package:gap/gap.dart';
import 'package:digify_security_console/security_console/workforce_bridge/presentation/widgets/job_families/job_family_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JobFamilyList extends ConsumerWidget {
  final SecurityConsoleLocalizations localizations;
  final bool isDark;

  const JobFamilyList({super.key, required this.localizations, required this.isDark});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paginationState = ref.watch(jobFamilyNotifierProvider);
    final jobLevels = ref.watch(jobLevelListProvider);

    if (paginationState.isLoading) {
      return const JobFamilySkeleton();
    }

    if (paginationState.hasError && paginationState.items.isEmpty) {
      return DigifyErrorState(
        message: paginationState.errorMessage ?? localizations.somethingWentWrong,
        retryLabel: localizations.retry,
        onRetry: () => ref.read(jobFamilyNotifierProvider.notifier).refresh(),
      );
    }

    if (paginationState.isEmpty) {
      return const JobFamilyEmptyState();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(minHeight: 500.h),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final maxW = constraints.maxWidth;
              final spacing = 24.w;
              final runSpacing = 24.h;
              final targetCardWidth = 466.0;

              final columns = maxW < 600
                  ? 1
                  : maxW < 900
                  ? 2
                  : 3;
              final computed = (maxW - (spacing * (columns - 1))) / columns;
              final cardWidth = computed > targetCardWidth ? targetCardWidth : computed;

              return Wrap(
                spacing: spacing,
                runSpacing: runSpacing,
                children: paginationState.items.asMap().entries.map<Widget>((entry) {
                  final jobFamily = entry.value;

                  return SizedBox(
                    width: cardWidth,
                    child: JobFamilyCard(
                      jobFamily: jobFamily,
                      jobLevels: jobLevels,
                      localizations: localizations,
                      isDark: isDark,
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),

        if (paginationState.totalPages > 0) ...[
          Gap(24.h),
          PaginationControls.fromPaginationInfo(
            paginationInfo: PaginationInfo(
              currentPage: paginationState.currentPage,
              totalPages: paginationState.totalPages,
              totalItems: paginationState.totalItems,
              pageSize: paginationState.pageSize,
              hasNext: paginationState.hasNextPage,
              hasPrevious: paginationState.hasPreviousPage,
            ),
            currentPage: paginationState.currentPage,
            pageSize: paginationState.pageSize,
            onPrevious: paginationState.hasPreviousPage
                ? () => ref.read(jobFamilyNotifierProvider.notifier).goToPage(paginationState.currentPage - 1)
                : null,
            onNext: paginationState.hasNextPage
                ? () => ref.read(jobFamilyNotifierProvider.notifier).goToPage(paginationState.currentPage + 1)
                : null,
            isLoading: paginationState.isLoading,
            style: PaginationStyle.simple,
          ),
          Gap(24.h),
        ],
      ],
    );
  }
}
