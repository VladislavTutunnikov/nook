import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nook/api/models/post_model.dart';
import 'package:nook/features/nook_screen/widgets/mini_post_card.dart';
import 'package:nook/generated/l10n.dart';
import 'package:nook/theme/icons.dart';

class PinnedPostList extends StatelessWidget {
  const PinnedPostList({super.key, required this.posts, this.scrollController});

  final List<PostModel> posts;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return posts.isEmpty
        ? const SizedBox()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(AppIcons.pin, width: 16),
                    const SizedBox(width: 5),
                    Text(
                      S.of(context).pinned,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 120,
                child: ListView.separated(
                  controller: scrollController,
                  scrollDirection: Axis.horizontal,
                  addAutomaticKeepAlives: true,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  // shrinkWrap: true,
                  itemCount: posts.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 15),
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    return MiniPostCard(
                      key: ValueKey(post.id),
                      title: post.title,
                      //TODO: add navigation to post screen
                      onTap: null,
                    );
                  },
                ),
              ),
            ],
          );
  }
}
