import 'package:flutter/material.dart';
import 'package:nook/api/models/post_model.dart';
import 'package:nook/generated/l10n.dart';
import 'package:nook/shared/widgets/loading_dots.dart';
import 'package:nook/features/post_card/widgets/post_card.dart';

class PostList extends StatelessWidget {
  const PostList({
    super.key,
    required this.posts,
    required this.showNook,
    this.onLikeTap,
    this.onCommentTap,
    this.onRepostTap,
    this.onShareTap,
    this.onMenuTap,
    this.showLoading = false,
  });

  final List<PostModel> posts;
  final bool showNook;
  final void Function(PostModel post)? onLikeTap;
  final void Function(PostModel post)? onCommentTap;
  final void Function(PostModel post)? onRepostTap;
  final void Function(PostModel post)? onShareTap;
  final void Function(PostModel post)? onMenuTap;
  final bool showLoading;

  @override
  Widget build(BuildContext context) {
    return posts.isEmpty
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
                addAutomaticKeepAlives: true,
                padding: const EdgeInsets.all(15),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: posts.length,
                separatorBuilder: (_, __) => const SizedBox(height: 15),
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return PostCard(
                    key: ValueKey(post.id),
                    post: post,
                    showNook: showNook,
                    onLikeTap: () => onLikeTap?.call(post),
                    onCommentTap: () => onCommentTap?.call(post),
                    onRepostTap: () => onRepostTap?.call(post),
                    onShareTap: () => onShareTap?.call(post),
                    onMenuTap: () => onMenuTap?.call(post),
                  );
                },
              ),

              showLoading ? const LoadingDots() : const SizedBox(height: 40),
            ],
          );
  }
}
