import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nook/features/nook_screen/widgets/nook_profile_info.dart';
import 'package:nook/generated/l10n.dart';
import 'package:nook/shared/widgets/avatar.dart';
import 'package:nook/shared/widgets/capsule_button.dart';
import 'package:nook/shared/widgets/custom_back_button.dart';
import 'package:nook/shared/widgets/custom_icon_button.dart';
import 'package:nook/theme/colors.dart';
import 'package:nook/theme/icons.dart';
import 'package:nook/theme/theme.dart';

class NookHeader extends StatelessWidget {
  const NookHeader({
    super.key,
    this.showMenu = false,
    this.onMenuTap,
    this.onFollowersTap,
    required this.isFollow,
    this.onFollowTap,
  });
  final bool showMenu;
  final bool isFollow;
  final void Function()? onMenuTap;
  final void Function()? onFollowersTap;
  final void Function()? onFollowTap;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.lightGrey, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CustomBackButton(color: AppColors.black),
                const Spacer(),
                showMenu
                    ? CustomIconButton(
                        iconPath: AppIcons.dots,
                        color: AppColors.black,
                        onTap: onMenuTap,
                      )
                    : const SizedBox(),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                NookProfileInfo(
                  avatarUrl: '',
                  name: 'Born4Music',
                  followersCount: 32,
                  onTap: onFollowersTap,
                ),
                const Spacer(),
                CapsuleButton(
                  onTap: onFollowTap,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 3,
                  ),
                  text: isFollow
                      ? S.of(context).unfollow
                      : S.of(context).follow,
                  textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: isFollow ? AppColors.black : AppColors.white,
                  ),
                  backgroundColor: isFollow ? AppColors.white : AppColors.black,
                  border: isFollow
                      ? Border.all(width: 1, color: AppColors.black)
                      : null,
                ),
              ],
            ),

            const SizedBox(height: 15),
            Text(
              'Do you hear the music?',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.darkGrey),
            ),
          ],
        ),
      ),
    );
  }
}
