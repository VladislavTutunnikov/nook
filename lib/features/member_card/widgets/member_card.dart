import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nook/api/models/nook_member_model.dart';
import 'package:nook/router/router.dart';
import 'package:nook/shared/widgets/avatar.dart';
import 'package:nook/shared/widgets/custom_icon_button.dart';
import 'package:nook/theme/colors.dart';
import 'package:nook/theme/icons.dart';

class MemberCard extends StatelessWidget {
  const MemberCard({
    super.key,
    required this.member,
    this.onMenuTap,
    this.showAsOwner = false,
    this.showMenu = false,
    required this.isOwner,
    required this.isModerator,
  });
  final NookMemberModel member;
  final bool showAsOwner;
  final bool showMenu;
  final void Function()? onMenuTap;

  final bool isOwner;
  final bool isModerator;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.lightGrey, width: 1),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () =>
                  AutoRouter.of(context).push(AccountRoute(userId: member.id)),
              child: Row(
                children: [
                  Avatar(avatarUrl: member.avatarUrl ?? ''),
                  const SizedBox(width: 10),
                  SvgPicture.asset(
                    showAsOwner
                        ? AppIcons.crown
                        : member.role == MemberRole.moderator
                        ? AppIcons.sparkle
                        : AppIcons.user,
                    width: 18,
                  ),
                  const SizedBox(width: 2),
                  Expanded(
                    child: Text(
                      member.username,
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),

          showMenu
              ? CustomIconButton(
                  iconPath: AppIcons.dots,
                  color: AppColors.black,
                  size: 22,
                  onTap: onMenuTap,
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
