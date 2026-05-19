import 'package:flutter/material.dart';
import 'package:nook/generated/l10n.dart';
import 'package:nook/shared/widgets/text_icon_button.dart';
import 'package:nook/theme/colors.dart';
import 'package:nook/theme/icons.dart';

class CreateMenuBottomSheet extends StatelessWidget {
  const CreateMenuBottomSheet({super.key, this.onPostTap, this.onNookTap});

  final void Function()? onPostTap;
  final void Function()? onNookTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 40, left: 25, right: 25),
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

          TextIconButton(
            padding: const EdgeInsets.only(bottom: 20),
            onTap: onPostTap,
            iconPath: AppIcons.commentPlus,
            text: S.of(context).createPost,
          ),
          TextIconButton(
            padding: const EdgeInsets.only(bottom: 20),
            onTap: onNookTap,
            iconPath: AppIcons.housePlus,
            text: S.of(context).createNook,
          ),
        ],
      ),
    );
  }
}
