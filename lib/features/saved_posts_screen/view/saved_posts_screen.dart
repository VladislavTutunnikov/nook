import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nook/api/di/injection.dart';
import 'package:nook/api/repositories/user_repository.dart';
import 'package:nook/features/saved_posts_screen/bloc/saved_posts_bloc.dart';
import 'package:nook/shared/widgets/custom_back_button.dart';
import 'package:nook/shared/widgets/error_message.dart';
import 'package:nook/shared/widgets/loading_dots.dart';
import 'package:nook/shared/widgets/post_list.dart';
import 'package:nook/theme/colors.dart';
import 'package:nook/theme/icons.dart';

@RoutePage()
class SavedPostsScreen extends StatefulWidget {
  const SavedPostsScreen({super.key});

  @override
  State<SavedPostsScreen> createState() => _SavedPostsScreenState();
}

class _SavedPostsScreenState extends State<SavedPostsScreen> {
  late final SavedPostsBloc _savedPostsBloc;

  bool _showFloatingButton = false;
  final ScrollController _scrollController = ScrollController();

  void _onScroll() {
    final state = _savedPostsBloc.state;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (maxScroll > 650) {
      if (currentScroll > 600 && !_showFloatingButton) {
        setState(() => _showFloatingButton = true);
      } else if (currentScroll < 600 && _showFloatingButton) {
        setState(() => _showFloatingButton = false);
      }
    }

    if (state is SavedPostsLoaded) {
      if (state.hasMore && currentScroll >= maxScroll - 200) {
        _savedPostsBloc.add(LoadSavedPosts(offset: state.offset));
      }
    }
  }

  Future<void> _onRefresh() async {
    _savedPostsBloc.add(LoadSavedPosts(isRefresh: true));
  }

  @override
  void initState() {
    super.initState();

    _savedPostsBloc = SavedPostsBloc(userRepository: getIt<UserRepository>());
    _savedPostsBloc.add(LoadSavedPosts(isRefresh: true));

    _scrollController.addListener(() => _onScroll());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SavedPostsBloc, SavedPostsState>(
        bloc: _savedPostsBloc,
        builder: (context, state) {
          if (state is SavedPostsLoaded) {
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 15, top: 60),
                              child: CustomBackButton(color: AppColors.black),
                            ),

                            PostList(
                              posts: state.savedPosts,
                              showNook: true,
                              showLoading: state.hasMore,
                            ),
                            const SizedBox(height: 60),
                          ],
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
          } else if (state is SavedPostsLoadingFailure) {
            return Center(child: ErrorMessage(onTap: _onRefresh));
          } else {
            return const Center(child: LoadingDots());
          }
        },
      ),
    );
  }
}
