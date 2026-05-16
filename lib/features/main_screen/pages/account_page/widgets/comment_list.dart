import 'package:flutter/material.dart';
import 'package:nook/api/models/comment_model.dart';
import 'package:nook/generated/l10n.dart';
import 'package:nook/shared/widgets/comment_card.dart';
import 'package:nook/shared/widgets/loading_dots.dart';

class CommentList extends StatelessWidget {
  const CommentList({
    super.key,
    required this.comments,
    this.onLikeTap,
    this.onCommentTap,
    this.onShareTap,
    this.onMenuTap,
    this.showLoading = false,
  });

  final List<CommentModel> comments;
  final bool showLoading;
  final void Function(CommentModel comment)? onLikeTap;
  final void Function(CommentModel comment)? onCommentTap;
  final void Function(CommentModel comment)? onShareTap;
  final void Function(CommentModel comment)? onMenuTap;

  @override
  Widget build(BuildContext context) {
    return comments.isEmpty
        ? Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              S.of(context).theresNothingHere,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          )
        : Column(
            children: [
              ListView.separated(
                padding: const EdgeInsets.all(15),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: comments.length,
                separatorBuilder: (_, __) => const SizedBox(height: 15),
                itemBuilder: (context, index) {
                  final comment = comments[index];
                  return CommentCard(
                    key: ValueKey(comment.id),
                    comment: comment,
                    onLikeTap: () => onLikeTap?.call(comment),
                    onCommentTap: () => onCommentTap?.call(comment),
                    onShareTap: () => onShareTap?.call(comment),
                    onMenuTap: () => onMenuTap?.call(comment),
                  );
                },
              ),

              showLoading ? const LoadingDots() : const SizedBox(height: 40),
            ],
          );
  }
}
