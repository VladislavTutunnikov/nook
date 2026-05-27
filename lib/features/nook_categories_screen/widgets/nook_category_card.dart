import 'package:flutter/material.dart';
import 'package:nook/theme/colors.dart';

class NookCategoryCard extends StatelessWidget {
  const NookCategoryCard({super.key, required this.categoryName, this.onTap});
  final String categoryName;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.lightGrey, width: 1),
        ),
        child: Text(categoryName, style: Theme.of(context).textTheme.titleMedium),
      ),
    );
  }
}
