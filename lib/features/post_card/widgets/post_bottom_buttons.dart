import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nook/generated/l10n.dart';
import 'package:nook/shared/utils/formaters.dart';
import 'package:nook/theme/colors.dart';
import 'package:nook/theme/icons.dart';

class PostBottomButtons extends StatelessWidget {
  const PostBottomButtons({
    super.key,
    required this.isLiked,
    required this.likeCount,
    this.onLikeTap,
    required this.commentCount,
    this.onCommentTap,
    required this.isReposted,
    required this.repostCount,
    this.onRepostTap,
    required this.isEdited,
    this.onShareTap,
  });

  final bool isLiked;
  final int likeCount;
  final void Function()? onLikeTap;

  final int commentCount;
  final void Function()? onCommentTap;

  final bool isReposted;
  final int repostCount;
  final void Function()? onRepostTap;

  final bool isEdited;

  final void Function()? onShareTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, bottom: 15, left: 15, right: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onLikeTap,
            child: Row(
              children: [
                SvgPicture.asset(
                  isLiked ? AppIcons.likeFilled : AppIcons.like,
                  width: 22,
                ),
                const SizedBox(width: 3),
                Text(
                  Formaters.formatNumber(likeCount),
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: isLiked ? AppColors.red : AppColors.black,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),

          GestureDetector(
            onTap: onCommentTap,
            child: Row(
              children: [
                SvgPicture.asset(AppIcons.comment, width: 22),
                const SizedBox(width: 3),
                Text(
                  Formaters.formatNumber(commentCount),
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),

          GestureDetector(
            onTap: onRepostTap,
            child: Row(
              children: [
                SvgPicture.asset(
                  isReposted ? AppIcons.repostChecked : AppIcons.repost,
                  width: 22,
                ),
                const SizedBox(width: 3),
                Text(
                  Formaters.formatNumber(repostCount),
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
          ),

          const Spacer(),
          isEdited
              ? Text(
                  S.of(context).edited,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: AppColors.darkGrey),
                )
              : const SizedBox(),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: onShareTap,
            child: SvgPicture.asset(AppIcons.share, width: 22),
          ),
        ],
      ),
    );
  }
}
