import 'package:flutter/material.dart';
import 'package:nook/theme/colors.dart';

class MenuBottomSheet extends StatelessWidget {
  const MenuBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 60, left: 25, right: 25),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.lightGrey, width: 1),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: AlignmentGeometry.center,
            child: Container(
              width: 70,
              height: 5,
              decoration: BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          const SizedBox(height: 20),

          Text('Сохранить', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 20),
          Text(
            'Копировать текст',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 20),
          Text('Редактировать', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 20),
          Text('Пожаловаться', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 20),
          Text('Удалить', style: Theme.of(context).textTheme.titleLarge),
        ],
      ),
    );
  }
}
