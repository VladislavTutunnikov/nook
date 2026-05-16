import 'package:flutter/material.dart';
import 'package:nook/features/main_screen/pages/account_page/widgets/stat_card.dart';
import 'package:nook/features/main_screen/pages/account_page/widgets/stat_time_card.dart';
import 'package:nook/generated/l10n.dart';

class StatsRow extends StatelessWidget {
  const StatsRow({
    super.key,
    required this.likeCount,
    required this.postCount,
    required this.commentCount,
    required this.createdAt,
  });

  final int likeCount;
  final int postCount;
  final int commentCount;
  final DateTime createdAt;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        StatCard(number: likeCount, label: S.of(context).likeCounter),
        const SizedBox(width: 15),
        StatCard(number: postCount, label: S.of(context).postCounter),
        const SizedBox(width: 15),
        StatCard(number: commentCount, label: S.of(context).commentCounter),
        const SizedBox(width: 15),
        StatTimeCard(time: createdAt, label: S.of(context).withNook),
      ],
    );
  }
}
