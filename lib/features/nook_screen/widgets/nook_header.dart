import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nook/api/models/nook_model.dart';
import 'package:nook/features/nook_screen/widgets/nook_header_buttons.dart';
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
    required this.nook,
    this.showMenu = false,
    this.onMenuTap,
    this.onFollowersTap,
    required this.isFollow,
    this.onFollowTap,
    this.showDescription = false,
    this.onDescriptionTap,
    this.onCreatePostTap,
    this.onRulesTap,
    this.onStatisticsTap,
    this.onTeamTap,
  });
  final NookModel nook;

  final bool showMenu;
  final bool isFollow;
  final bool showDescription;
  final void Function()? onMenuTap;
  final void Function()? onFollowersTap;
  final void Function()? onFollowTap;

  final void Function()? onDescriptionTap;

  final void Function()? onCreatePostTap;
  final void Function()? onRulesTap;
  final void Function()? onStatisticsTap;
  final void Function()? onTeamTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.lightGrey, width: 1),
      ),
      child: Column(
        children: [
          Padding(
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
                    Expanded(
                      child: NookProfileInfo(
                        avatarUrl: nook.avatarUrl ?? '',
                        name: nook.name,
                        followersCount: 32,
                        onTap: onFollowersTap,
                      ),
                    ),
                    CapsuleButton(
                      onTap: onFollowTap,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 3,
                      ),
                      text: isFollow
                          ? S.of(context).unfollow
                          : S.of(context).follow,
                      textStyle: Theme.of(context).textTheme.titleMedium
                          ?.copyWith(
                            color: isFollow ? AppColors.black : AppColors.white,
                          ),
                      backgroundColor: isFollow
                          ? AppColors.white
                          : AppColors.black,
                      border: isFollow
                          ? Border.all(width: 1, color: AppColors.black)
                          : null,
                    ),
                  ],
                ),

                nook.description != null && nook.description != ''
                    ? Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: AnimatedSize(
                          duration: const Duration(milliseconds: 200),
                          child: GestureDetector(
                            onTap: onDescriptionTap,
                            child: Text(
                              nook.description!,
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(color: AppColors.darkGrey),
                              maxLines: showDescription ? null : 2,
                              overflow: showDescription
                                  ? null
                                  : TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
          const SizedBox(height: 15),
          NookHeaderButtons(
            onCreatePostTap: onCreatePostTap,
            onRulesTap: onRulesTap,
            onStatisticsTap: onStatisticsTap,
            onTeamTap: onTeamTap,
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
