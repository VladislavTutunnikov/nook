import 'package:flutter/material.dart';
import 'package:nook/theme/colors.dart';

class MiniPostCard extends StatelessWidget {
  const MiniPostCard({super.key, required this.title, this.onTap});
  final String title;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        width: 250,
        height: 120,
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.lightGrey, width: 1),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(
          title,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
