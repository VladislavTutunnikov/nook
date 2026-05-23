import 'package:flutter/material.dart';
import 'package:nook/generated/l10n.dart';
import 'package:nook/shared/widgets/bottom_sheet_container.dart';
import 'package:nook/shared/widgets/text_icon_button.dart';
import 'package:nook/theme/colors.dart';
import 'package:nook/theme/icons.dart';

class MemberMenuBottomSheet extends StatelessWidget {
  const MemberMenuBottomSheet({
    super.key,
    this.onModeratorTap,
    this.onBanTap,
    required this.isModerator,
    required this.isBanned,
    required this.showModerator,
  });
  final void Function()? onModeratorTap;
  final void Function()? onBanTap;
  final bool isModerator;
  final bool isBanned;
  final bool showModerator;

  @override
  Widget build(BuildContext context) {
    return BottomSheetContainer(
      child: Column(
        children: [
          showModerator
              ? TextIconButton(
                  onTap: onModeratorTap,
                  padding: const EdgeInsets.only(bottom: 20),
                  iconPath: isModerator ? AppIcons.user : AppIcons.sparkle,
                  text: isModerator
                      ? S.of(context).deleteModerator
                      : S.of(context).addModerator,
                )
              : const SizedBox(),
          TextIconButton(
            onTap: onBanTap,
            padding: const EdgeInsets.only(bottom: 20),
            iconColor: isBanned ? AppColors.darkGreen : AppColors.darkRed,
            iconPath: isBanned ? AppIcons.circleCheck : AppIcons.ban,
            text: isBanned ? S.of(context).unban : S.of(context).ban,
            textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: isBanned ? AppColors.darkGreen : AppColors.darkRed,
            ),
          ),
        ],
      ),
    );
  }
}
