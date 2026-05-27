import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nook/api/models/category_model.dart';
import 'package:nook/generated/l10n.dart';
import 'package:nook/theme/colors.dart';
import 'package:nook/theme/icons.dart';

class ChooseCategoryButton extends StatelessWidget {
  const ChooseCategoryButton({super.key, this.category, this.onTap});
  final CategoryModel? category;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: BoxBorder.all(width: 1, color: AppColors.lightGrey),
        borderRadius: BorderRadius.circular(20),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Text(
              category?.name ?? S.of(context).chooseCategory,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(width: 2),
            SvgPicture.asset(AppIcons.chevronsUpDown, width: 20, height: 20),
          ],
        ),
      ),
    );
  }
}
