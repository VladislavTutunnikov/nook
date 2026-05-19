import 'package:flutter/material.dart';
import 'package:nook/shared/widgets/custom_back_button.dart';
import 'package:nook/shared/widgets/custom_icon_button.dart';
import 'package:nook/theme/icons.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({
    super.key,
    this.onPlusTap,
    this.onEditTap,
    this.onMenuTap,
    required this.isOwnerProfile,
  });

  final bool isOwnerProfile;
  final void Function()? onPlusTap;
  final void Function()? onEditTap;
  final void Function()? onMenuTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        isOwnerProfile
            ? CustomIconButton(iconPath: AppIcons.plusSquare, onTap: onPlusTap)
            : const CustomBackButton(),
        const Spacer(),
        isOwnerProfile
            ? CustomIconButton(iconPath: AppIcons.edit, onTap: onEditTap)
            : const SizedBox(),
        const SizedBox(width: 15),
        isOwnerProfile
            ? CustomIconButton(iconPath: AppIcons.burgerMenu, onTap: onMenuTap)
            : const SizedBox(),
      ],
    );
  }
}
