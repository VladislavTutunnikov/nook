import 'package:flutter/material.dart';
import 'package:nook/generated/l10n.dart';
import 'package:nook/shared/widgets/text_icon_button.dart';
import 'package:nook/theme/colors.dart';
import 'package:nook/theme/icons.dart';

class MenuBottomSheet extends StatelessWidget {
  const MenuBottomSheet({
    super.key,
    this.showEdit = false,
    this.showDelete = false,
    this.isSaved = false,
    this.onSaveTap,
    this.onCopyTap,
    this.onEditTap,
    this.onReportTap,
    this.onDeleteTap,
  });

  final bool showEdit;
  final bool showDelete;
  final bool isSaved;

  final void Function()? onSaveTap;
  final void Function()? onCopyTap;
  final void Function()? onEditTap;
  final void Function()? onReportTap;
  final void Function()? onDeleteTap;

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
            onTap: onSaveTap,
            iconPath: isSaved ? AppIcons.saveFilled : AppIcons.save,
            text: isSaved ? S.of(context).removeFromSaved : S.of(context).save,
          ),
          TextIconButton(
            padding: const EdgeInsets.only(bottom: 20),
            onTap: onCopyTap,
            iconPath: AppIcons.copy,
            text: S.of(context).copyText,
          ),

          showEdit
              ? TextIconButton(
                  padding: const EdgeInsets.only(bottom: 20),
                  onTap: onEditTap,
                  iconPath: AppIcons.edit,
                  text: S.of(context).edit,
                )
              : const SizedBox(),

          TextIconButton(
            padding: const EdgeInsets.only(bottom: 20),
            onTap: onReportTap,
            iconPath: AppIcons.report,
            iconColor: AppColors.darkRed,
            text: S.of(context).report,
            textStyle: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(color: AppColors.darkRed),
          ),

          showDelete
              ? TextIconButton(
                  padding: const EdgeInsets.only(bottom: 20),
                  onTap: onDeleteTap,
                  iconPath: AppIcons.delete,
                  iconColor: AppColors.darkRed,
                  text: S.of(context).delete,
                  textStyle: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(color: AppColors.darkRed),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
