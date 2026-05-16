import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nook/api/models/post_model.dart';
import 'package:nook/features/post_card/widgets/post_header.dart';
import 'package:nook/generated/l10n.dart';
import 'package:nook/router/router.dart';
import 'package:nook/shared/utils/formaters.dart';
import 'package:nook/shared/widgets/avatar.dart';
import 'package:nook/shared/widgets/photos_list.dart';
import 'package:nook/shared/widgets/username.dart';
import 'package:nook/theme/colors.dart';
import 'package:nook/theme/icons.dart';

class PostCard extends StatefulWidget {
  const PostCard({
    super.key,
    required this.post,
    this.showNook = false,
    this.onLikeTap,
    this.onCommentTap,
    this.onRepostTap,
    this.onShareTap,
    this.onMenuTap,
  });

  final PostModel post;
  final bool showNook;

  final VoidCallback? onLikeTap;
  final VoidCallback? onCommentTap;
  final VoidCallback? onRepostTap;
  final VoidCallback? onShareTap;
  final VoidCallback? onMenuTap;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late int _likeCount;
  late int _repostCount;
  late bool _isLiked;
  late bool _isReposted;

  @override
  void initState() {
    super.initState();
    _likeCount = widget.post.likeCount;
    _repostCount = widget.post.repostCount;
    _isLiked = widget.post.isLiked;
    _isReposted = widget.post.isReposted;
  }

  void _handleLike() {
    setState(() {
      _isLiked ? _likeCount-- : _likeCount++;
      _isLiked = !_isLiked;
    });
    widget.onLikeTap?.call();
  }

  void _handleRepost() {
    setState(() {
      _isReposted ? _repostCount-- : _repostCount++;
      _isReposted = !_isReposted;
    });
    widget.onRepostTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.lightGrey, width: 1),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: PostHeader(
                        isNook: widget.showNook,
                        avatarUrl: widget.showNook
                            ? widget.post.nook.avatarUrl ?? ''
                            : widget.post.user.avatarUrl ?? '',
                        username: widget.showNook
                            ? widget.post.nook.name
                            : widget.post.user.username,
                        onAvatarTap: () {
                          if (widget.showNook) {
                            //TODO: add navigation to nook screen
                          } else {
                            AutoRouter.of(
                              context,
                            ).push(AccountRoute(userId: widget.post.user.id));
                          }
                        },
                        createdAt: widget.post.createdAt,
                      ),
                    ),

                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: widget.onMenuTap,
                      child: SvgPicture.asset(AppIcons.dots, width: 22),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  widget.post.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                widget.post.content != null
                    ? Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          widget.post.content!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(color: AppColors.darkGrey),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),

          widget.post.photos.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: PhotosList(imgUrls: widget.post.photos),
                )
              : const SizedBox(),

          Padding(
            padding: const EdgeInsets.only(
              top: 0,
              bottom: 15,
              left: 15,
              right: 15,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _handleLike,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        _isLiked ? AppIcons.likeFilled : AppIcons.like,
                        width: 22,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        Formaters.formatNumber(_likeCount),
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: _isLiked ? AppColors.red : AppColors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),

                GestureDetector(
                  onTap: widget.onCommentTap,
                  child: Row(
                    children: [
                      SvgPicture.asset(AppIcons.comment, width: 22),
                      const SizedBox(width: 3),
                      Text(
                        Formaters.formatNumber(widget.post.commentCount),
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),

                GestureDetector(
                  onTap: _handleRepost,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        _isReposted ? AppIcons.repostChecked : AppIcons.repost,
                        width: 22,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        Formaters.formatNumber(_repostCount),
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                ),

                const Spacer(),
                widget.post.isEdited
                    ? Text(
                        S.of(context).edited,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.darkGrey,
                        ),
                      )
                    : const SizedBox(),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: widget.onShareTap,
                  child: SvgPicture.asset(AppIcons.share, width: 22),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
