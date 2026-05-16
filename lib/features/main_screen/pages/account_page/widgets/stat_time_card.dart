import 'package:flutter/material.dart';
import 'package:nook/theme/colors.dart';

class StatTimeCard extends StatelessWidget {
  const StatTimeCard({super.key, required this.time, required this.label});

  final DateTime time;
  final String label;

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);
    final days = difference.inDays;

    if (days >= 365) {
      final years = (days / 365).floor();
      return '${years}y.';
    } else if (days >= 30) {
      final months = (days / 30).floor();
      return '${months}m.';
    } else if (days >= 1) {
      return '${days}d.';
    } else {
      final hours = difference.inHours;
      return '${hours}h.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _formatTime(time),
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
