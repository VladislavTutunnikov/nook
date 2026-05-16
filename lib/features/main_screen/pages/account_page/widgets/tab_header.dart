import 'package:flutter/material.dart';
import 'package:nook/theme/colors.dart';

class TabHeader extends StatelessWidget {
  const TabHeader({
    super.key,
    required this.tabs,
    this.onTap,
    required this.currentIndex,
  });

  final List<String> tabs;
  final int currentIndex;
  final void Function(int index)? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          bottom: BorderSide(color: AppColors.lightGrey, width: 1),
        ),
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        separatorBuilder: (_, __) => const SizedBox(width: 15),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        itemBuilder: (context, index) {
          final isSelected = currentIndex == index;
          return GestureDetector(
            onTap: () => onTap?.call(index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isSelected ? AppColors.black : AppColors.transparent,
                    width: 1,
                  ),
                ),
              ),
              child: Text(
                tabs[index],
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: isSelected ? AppColors.black : AppColors.darkGrey,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
