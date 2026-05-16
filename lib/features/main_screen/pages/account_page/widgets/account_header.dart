import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nook/api/models/user_model.dart';
import 'package:nook/features/main_screen/pages/account_page/widgets/background_blur_image.dart';
import 'package:nook/features/main_screen/pages/account_page/widgets/following_nooks.dart';
import 'package:nook/features/main_screen/pages/account_page/widgets/stats_row.dart';
import 'package:nook/features/main_screen/pages/account_page/widgets/top_buttons.dart';
import 'package:nook/shared/widgets/avatar.dart';
import 'package:nook/theme/colors.dart';
import 'package:nook/theme/icons.dart';

class AccountHeader extends StatelessWidget {
  const AccountHeader({
    super.key,
    required this.user,
    required this.followingUrls,
    required this.isOwnerProfile,
    this.onFollowingTap,
    this.onQrTap,
    this.onEditTap,
    this.onMenuTap,
  });

  final UserModel user;
  final List<String> followingUrls;
  final bool isOwnerProfile;
  final void Function()? onFollowingTap;
  final void Function()? onQrTap;
  final void Function()? onEditTap;
  final void Function()? onMenuTap;

  @override
  Widget build(BuildContext context) {
    return BackgroundBlurImage(
      imgUrl: user.avatarUrl ?? '',
      child: Padding(
        padding: const EdgeInsets.only(
          top: 70,
          left: 10,
          right: 10,
          bottom: 15,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsetsGeometry.symmetric(horizontal: 10),
              child: TopButtons(
                isOwnerProfile: isOwnerProfile,
                onQrTap: onQrTap,
                onEditTap: onEditTap,
                onMenuTap: onMenuTap,
              ),
            ),
            const SizedBox(height: 25),
            Avatar(avatarUrl: user.avatarUrl ?? '', size: 150),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(AppIcons.userWhite, width: 24),
                  const SizedBox(width: 5),
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        user.username,
                        style: Theme.of(context).textTheme.headlineLarge
                            ?.copyWith(color: AppColors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FollowingNooks(
                  followingUrls: followingUrls,
                  onTap: onFollowingTap,
                ),
                const Spacer(),
                StatsRow(
                  likeCount: user.likeCount,
                  postCount: user.postCount,
                  commentCount: user.commentCount,
                  createdAt: user.createdAt,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
