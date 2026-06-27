import 'package:digify_core/constants/app_colors.dart';
import 'package:digify_core/widgets/feedback/placeholder_screen.dart';
import 'package:flutter/material.dart';

class SegregationOfDutiesScreen extends StatelessWidget {
  const SegregationOfDutiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      color: isDark ? AppColors.backgroundDark : AppColors.tableHeaderBackground,
      child: const PlaceholderScreen(title: 'Segregation of Duties'),
    );
  }
}
