import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nook/features/nook_screen/widgets/nook_header.dart';

@RoutePage()
class NookScreen extends StatelessWidget {
  const NookScreen({super.key, required this.nookId});
  final String nookId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: NookHeader(
              //TODO: change this
              showMenu: true,
              isFollow: true,
              //TODO: add functionality
              onMenuTap: null,
              onFollowersTap: null,
              onFollowTap: null,
            ),
          ),
        ],
      ),
    );
  }
}
