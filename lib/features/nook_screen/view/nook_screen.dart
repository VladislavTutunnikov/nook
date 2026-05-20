import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nook/api/models/nook_model.dart';
import 'package:nook/features/nook_screen/widgets/nook_header.dart';
import 'package:nook/features/nook_screen/widgets/pinned_post_list.dart';

@RoutePage()
class NookScreen extends StatefulWidget {
  const NookScreen({super.key, required this.nookId});
  final String nookId;

  @override
  State<NookScreen> createState() => _NookScreenState();
}

class _NookScreenState extends State<NookScreen> {
  bool _showDescription = false;

  //TODO: delete placeholder data
  final nook = NookModel(
    id: "f8803238-80dc-489a-8a09-94a24e639a7c",
    name: "Born4Music",
    description: "Do you hear the music",
    avatarUrl: "/static/avatars/e64a1f0f-b6ac-42b1-ad96-136e56f9a007.webp",
    rules: "no rules",
    isOver18: false,
    followersCount: 3,
    postCount: 1,
    categoryId: "462ae83a-f3f9-408e-90d7-136f33e5b3c2",
    ownerId: "8f7f3d7e-21d8-4018-8d47-5732671941d1",
    createdAt: DateTime.parse("2026-03-18T19:17:48.265150Z"),
    isFollowed: true,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: NookHeader(
              nook: nook,
              //TODO: change this
              showMenu: true,
              isFollow: true,
              //TODO: add functionality
              onMenuTap: null,
              onFollowersTap: null,
              onFollowTap: null,
              showDescription: _showDescription,
              onDescriptionTap: () => setState(() {
                _showDescription = !_showDescription;
              }),
              onCreatePostTap: null,
              onRulesTap: null,
              onStatisticsTap: null,
              onTeamTap: null,
            ),
          ),
          SliverToBoxAdapter(child: PinnedPostList()),
        ],
      ),
    );
  }
}
