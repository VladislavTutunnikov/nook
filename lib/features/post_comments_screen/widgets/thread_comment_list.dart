import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nook/api/models/comment_model.dart';
import 'package:nook/generated/l10n.dart';
import 'package:nook/shared/widgets/comment_card.dart';
import 'package:nook/shared/widgets/loading_dots.dart';
import 'package:nook/theme/colors.dart';

class ThreadCommentList extends StatelessWidget {
  const ThreadCommentList({
    super.key,
    required this.comments,
    this.showLoading = false,
  });
  final List<CommentModel> comments;
  final bool showLoading;
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
              ListView.builder(
                padding: const EdgeInsets.only(bottom: 120),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  final comment = comments[index];
                  return Padding(
                    //TODO: add depth
                    // padding: EdgeInsets.only(left: comment.depth * 10),
                    padding: EdgeInsets.all(0),
                    child: CommentCard(
                      key: ValueKey(comment.id),
                      comment: comment,
                      borderRadius: 0,
                      border: Border.all(color: AppColors.transparent),
                    ),
                  );
                },
              ),

              showLoading ? const LoadingDots() : const SizedBox(height: 40),
            ],
          );
  }
}
