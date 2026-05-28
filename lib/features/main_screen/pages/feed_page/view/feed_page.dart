import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nook/api/di/injection.dart';
import 'package:nook/api/repositories/post_repository.dart';
import 'package:nook/features/main_screen/pages/feed_page/bloc/feed_bloc.dart';
import 'package:nook/features/main_screen/pages/feed_page/widgets/feed_header.dart';
import 'package:nook/generated/l10n.dart';
import 'package:nook/shared/widgets/error_message.dart';
import 'package:nook/shared/widgets/loading_dots.dart';
import 'package:nook/shared/widgets/post_list.dart';
import 'package:nook/theme/colors.dart';
import 'package:nook/theme/icons.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final FeedBloc _feedBloc = FeedBloc(postRepository: getIt<PostRepository>());

  bool _showFloatingButton = false;
  final ScrollController _scrollController = ScrollController();

  void _onScroll() {
    final state = _feedBloc.state;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (maxScroll > 650) {
      if (currentScroll > 600 && !_showFloatingButton) {
        setState(() => _showFloatingButton = true);
      } else if (currentScroll < 600 && _showFloatingButton) {
        setState(() => _showFloatingButton = false);
      }
    }

    if (state is FeedLoaded) {
      if (state.hasMore && currentScroll >= maxScroll - 200) {
        _feedBloc.add(LoadFeed(offset: state.offset));
      }
    }
  }

  Future<void> _onRefresh() async {
    _feedBloc.add(LoadFeed(isRefresh: true));
  }

  @override
  void initState() {
    super.initState();
    _feedBloc.add(LoadFeed(isRefresh: true));

    _scrollController.addListener(() => _onScroll());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedBloc, FeedState>(
      bloc: _feedBloc,
      builder: (context, state) {
        if (state is FeedLoaded) {
          return Stack(
            children: [
              RefreshIndicator(
                backgroundColor: AppColors.white,
                color: AppColors.black,
                onRefresh: _onRefresh,
                child: CustomScrollView(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          const FeedHeader(),
                          PostList(
                            posts: state.posts,
                            showNook: true,
                            showLoading: state.hasMore,
                            placeholderText: S.of(context).emptyFeedMessage,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 10,
                bottom: 10,
                child: _showFloatingButton
                    ? FloatingActionButton(
                        elevation: 0,
                        onPressed: () {
                          _scrollController.animateTo(
                            0,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeOut,
                          );
                        },
                        child: SvgPicture.asset(
                          AppIcons.chevronUp,
                          width: 30,
                          height: 30,
                        ),
                      )
                    : const SizedBox(),
              ),
            ],
          );
        } else if (state is FeedLoadingFailure) {
          return Center(child: ErrorMessage(onTap: _onRefresh));
        } else {
          return const Center(child: LoadingDots());
        }
      },
    );
  }
}
