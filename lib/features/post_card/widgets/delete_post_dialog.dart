import 'package:flutter/material.dart';
import 'package:nook/generated/l10n.dart';
import 'package:nook/shared/widgets/text_icon_button.dart';
import 'package:nook/theme/colors.dart';

class DeletePostDialog extends StatelessWidget {
  const DeletePostDialog({super.key, this.onDeleteTap});
  final void Function()? onDeleteTap;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              S.of(context).confirmationOfPostDeletion,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextIconButton(
                  isExpanded: false,
                  onTap: () => Navigator.pop(context),
                  iconPath: null,
                  text: S.of(context).cancel,
                ),
                const SizedBox(width: 30),
                TextIconButton(
                  isExpanded: false,
                  onTap: () {
                    Navigator.pop(context);
                    onDeleteTap?.call();
                  },
                  iconPath: null,
                  text: S.of(context).delete,
                  textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.darkRed,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
