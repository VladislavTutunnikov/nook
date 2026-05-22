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
    this.showLoading = false,
    this.padding = const EdgeInsets.all(15),
  });

  final List<PostModel> posts;
  final bool showNook;
  final bool showLoading;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return posts.isEmpty
        ? Padding(
            padding: padding,
            child: Text(
              S.of(context).theresNothingHere,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          )
        : Column(
            children: [
              ListView.separated(
                addAutomaticKeepAlives: true,
                padding: padding,
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
                  );
                },
              ),

              showLoading ? const LoadingDots() : const SizedBox(height: 40),
            ],
          );
  }
}
