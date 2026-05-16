import 'package:flutter/material.dart';
import 'package:nook/shared/utils/formaters.dart';
import 'package:nook/theme/colors.dart';

class StatCard extends StatelessWidget {
  const StatCard({super.key, required this.number, required this.label});

  final int number;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Formaters.formatNumber(number),
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(color: AppColors.white),
        ),
      ],
    );
  }
}
