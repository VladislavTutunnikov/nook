import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nook/api/di/injection.dart';
import 'package:nook/api/models/nook_model.dart';
import 'package:nook/api/models/nook_preview_model.dart';
import 'package:nook/api/models/post_model.dart';
import 'package:nook/api/models/user_preview_model.dart';
import 'package:nook/api/nook_api.dart';
import 'package:nook/api/repositories/nook_repository.dart';
import 'package:nook/api/repositories/user_repository.dart';
import 'package:nook/features/main_screen/pages/account_page/bloc/content_bloc/content_bloc.dart';
import 'package:nook/features/nook_screen/bloc/nook_bloc/nook_bloc.dart';
import 'package:nook/features/nook_screen/bloc/nook_pinned_bloc/nook_pinned_bloc.dart';
import 'package:nook/features/nook_screen/bloc/nook_posts_bloc/nook_posts_bloc.dart';
import 'package:nook/features/nook_screen/widgets/nook_header.dart';
import 'package:nook/features/nook_screen/widgets/pinned_post_list.dart';
import 'package:nook/features/nook_screen/widgets/posts_filter_menu_bottom_sheet.dart';
import 'package:nook/generated/l10n.dart';
import 'package:nook/router/router.dart';
import 'package:nook/shared/widgets/error_message.dart';
import 'package:nook/shared/widgets/loading_dots.dart';
import 'package:nook/shared/widgets/post_list.dart';
import 'package:nook/shared/widgets/text_icon_button.dart';
import 'package:nook/theme/colors.dart';
import 'package:nook/theme/icons.dart';

@RoutePage()
class NookScreen extends StatefulWidget {
  const NookScreen({super.key, required this.nookId});
  final String nookId;

  @override
  State<NookScreen> createState() => _NookScreenState();
}

class _NookScreenState extends State<NookScreen> {
  bool _showDescription = false;
  bool _showFloatingButton = false;
  PostFilter _postFilter = PostFilter.byPopularity;

  final ScrollController _mainScrollController = ScrollController();
  final ScrollController _pinnedPostsScrollController = ScrollController();

  late final NookBloc _nookBloc;
  late final NookPostsBloc _nookPostsBloc;
  late final NookPinnedBloc _nookPinnedBloc;

  Future<void> _onRefresh() async {
    _nookBloc.add(LoadNookData());
    _nookPostsBloc.add(LoadNookPosts(filter: _postFilter, isRefresh: true));
    _nookPinnedBloc.add(LoadNookPinnedPosts(isRefresh: true));
  }

  void _onScroll() {
    final state = _nookPostsBloc.state;

    final maxScroll = _mainScrollController.position.maxScrollExtent;
    final currentScroll = _mainScrollController.position.pixels;

    if (maxScroll > 650) {
      if (currentScroll > 600 && !_showFloatingButton) {
        setState(() => _showFloatingButton = true);
      } else if (currentScroll < 600 && _showFloatingButton) {
        setState(() => _showFloatingButton = false);
      }
    }

    if (state is NookPostsLoaded) {
      if (state.hasMore && currentScroll >= maxScroll - 200) {
        _nookPostsBloc.add(
          LoadNookPosts(filter: _postFilter, offset: state.offset),
        );
      }
    }
  }

  void _onPinnedPostsScroll() {
    final state = _nookPinnedBloc.state;

    final maxScroll = _pinnedPostsScrollController.position.maxScrollExtent;
    final currentScroll = _pinnedPostsScrollController.position.pixels;

    if (state is NookPinnedPostsLoaded) {
      if (state.hasMore && currentScroll >= maxScroll - 300) {
        _nookPinnedBloc.add(LoadNookPinnedPosts(offset: state.offset));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _nookBloc = NookBloc(
      nookRepository: getIt<NookRepository>(),
      userRepository: getIt<UserRepository>(),
      nookId: widget.nookId,
    );
    _nookPostsBloc = NookPostsBloc(
      nookRepository: getIt<NookRepository>(),
      nookId: widget.nookId,
    );
    _nookPinnedBloc = NookPinnedBloc(
      nookRepository: getIt<NookRepository>(),
      nookId: widget.nookId,
    );
    _nookBloc.add(LoadNookData());
    _nookPostsBloc.add(LoadNookPosts(filter: _postFilter));
    _nookPinnedBloc.add(LoadNookPinnedPosts());

    _mainScrollController.addListener(() => _onScroll());
    _pinnedPostsScrollController.addListener(() => _onPinnedPostsScroll());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NookBloc, NookState>(
        bloc: _nookBloc,
        builder: (context, state) {
          if (state is NookLoaded) {
            return Stack(
              children: [
                RefreshIndicator(
                  color: AppColors.black,
                  backgroundColor: AppColors.white,
                  onRefresh: _onRefresh,
                  child: CustomScrollView(
                    controller: _mainScrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    slivers: [
                      SliverToBoxAdapter(
                        child: NookHeader(
                          nook: state.nook,
                          //TODO: change this
                          showMenu: state.isOwner,
                          isFollowed: state.isFollowed,
                          followersCount: state.followersCount,
                          //TODO: add functionality
                          onMenuTap: null,
                          onFollowersTap: null,
                          onFollowTap: () => _nookBloc.add(FollowNook()),
                          showDescription: _showDescription,
                          onDescriptionTap: () => setState(() {
                            _showDescription = !_showDescription;
                          }),
                          onCreatePostTap: null,
                          onRulesTap: () => AutoRouter.of(context).push(
                            NookRulesRoute(
                              nookName: state.nook.name,
                              rules: state.nook.rules,
                            ),
                          ),
                          onStatisticsTap: null,
                          onTeamTap: () => AutoRouter.of(context).push(
                            NookTeamRoute(
                              nookId: widget.nookId,
                            ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: BlocBuilder<NookPinnedBloc, NookPinnedState>(
                          bloc: _nookPinnedBloc,
                          builder: (context, state) {
                            if (state is NookPinnedPostsLoaded) {
                              return PinnedPostList(
                                scrollController: _pinnedPostsScrollController,
                                posts: state.posts,
                                showLoading: state.hasMore,
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                      ),

                      SliverToBoxAdapter(
                        child: TextIconButton(
                          padding: const EdgeInsetsGeometry.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          gap: 5,
                          iconPath: AppIcons.options,
                          iconSize: 16,
                          text: _postFilter == PostFilter.byPopularity
                              ? S.of(context).popular
                              : S.of(context).fresh,
                          textStyle: Theme.of(context).textTheme.titleMedium,
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => PostsFilterMenuBottomSheet(
                                onPopularTap: () {
                                  Navigator.pop(context);
                                  setState(() {
                                    _postFilter = PostFilter.byPopularity;
                                  });
                                  _nookPostsBloc.add(
                                    LoadNookPosts(
                                      filter: _postFilter,
                                      isRefresh: true,
                                    ),
                                  );
                                },
                                onNewTap: () {
                                  Navigator.pop(context);
                                  setState(() {
                                    _postFilter = PostFilter.byNovelty;
                                  });
                                  _nookPostsBloc.add(
                                    LoadNookPosts(
                                      filter: _postFilter,
                                      isRefresh: true,
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: BlocBuilder<NookPostsBloc, NookPostsState>(
                          bloc: _nookPostsBloc,
                          builder: (context, state) {
                            if (state is NookPostsLoaded) {
                              return PostList(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                                posts: state.posts,
                                showNook: false,
                                showLoading: state.hasMore,
                              );
                            }
                            return Center(
                              child: ErrorMessage(onTap: _onRefresh),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 40,
                  child: _showFloatingButton
                      ? FloatingActionButton(
                          elevation: 0,
                          onPressed: () {
                            _mainScrollController.animateTo(
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
          } else if (state is NookLoadingFailure) {
            return Center(child: ErrorMessage(onTap: _onRefresh));
          } else {
            return const Center(child: LoadingDots());
          }
        },
      ),
    );
  }
}
