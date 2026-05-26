import 'package:flutter/material.dart';
import 'package:nook/generated/l10n.dart';
import 'package:nook/shared/widgets/bottom_sheet_container.dart';
import 'package:nook/shared/widgets/text_icon_button.dart';
import 'package:nook/theme/colors.dart';
import 'package:nook/theme/icons.dart';

class NookMenuBottomSheet extends StatelessWidget {
  const NookMenuBottomSheet({super.key, this.onEditTap, this.onDeleteTap});
  final void Function()? onEditTap;
  final void Function()? onDeleteTap;
  @override
  Widget build(BuildContext context) {
    return BottomSheetContainer(
      child: Column(
        children: [
          TextIconButton(
            padding: const EdgeInsets.only(bottom: 20),
            onTap: onEditTap,
            iconPath: AppIcons.edit,
            text: S.of(context).edit,
          ),

          TextIconButton(
            padding: const EdgeInsets.only(bottom: 20),
            onTap: onDeleteTap,
            iconPath: AppIcons.delete,
            iconColor: AppColors.darkRed,
            text: S.of(context).delete,
            textStyle: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(color: AppColors.darkRed),
          ),
        ],
      ),
    );
  }
}
