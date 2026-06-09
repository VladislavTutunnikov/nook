import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nook/api/models/comment_model.dart';
import 'package:nook/generated/l10n.dart';
import 'package:nook/shared/utils/formaters.dart';
import 'package:nook/shared/widgets/avatar.dart';
import 'package:nook/shared/widgets/photos_list.dart';
import 'package:nook/shared/widgets/username.dart';
import 'package:nook/theme/colors.dart';
import 'package:nook/theme/icons.dart';

class CommentCard extends StatefulWidget {
  const CommentCard({
    super.key,
    required this.comment,
    this.onLikeTap,
    this.onCommentTap,
    this.onShareTap,
    this.onMenuTap,
    this.borderRadius = 25,
    this.border,
  });

  final CommentModel comment;
  final double borderRadius;
  final BoxBorder? border;

  final VoidCallback? onLikeTap;
  final VoidCallback? onCommentTap;
  final VoidCallback? onShareTap;
  final VoidCallback? onMenuTap;

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  late int _likeCount;
  late bool _isLiked;

  @override
  void initState() {
    super.initState();
    _likeCount = widget.comment.likeCount;
    _isLiked = widget.comment.isLiked;
  }

  void _handleLike() {
    setState(() {
      _isLiked ? _likeCount-- : _likeCount++;
      _isLiked = !_isLiked;
    });
    widget.onLikeTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: widget.border == null
            ? Border.all(color: AppColors.lightGrey, width: 1)
            : widget.border!,
        borderRadius: BorderRadius.circular(widget.borderRadius),
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
                  children: [
                    Avatar(avatarUrl: widget.comment.user.avatarUrl ?? ''),
                    const SizedBox(width: 5),
                    Username(username: widget.comment.user.username),
                    const SizedBox(width: 10),
                    Text(
                      Formaters.formatTime(widget.comment.createdAt, context),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.darkGrey,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: widget.onMenuTap,
                      child: SvgPicture.asset(AppIcons.dots, width: 22),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                //max length 38 - 3 ...
                Text(
                  widget.comment.content,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),

          widget.comment.photos.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: PhotosList(imgUrls: widget.comment.photos),
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
                        Formaters.formatNumber(widget.comment.commentCount),
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                ),

                const Spacer(),
                widget.comment.isEdited
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
