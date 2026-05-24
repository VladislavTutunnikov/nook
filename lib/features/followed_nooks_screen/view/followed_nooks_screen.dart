import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nook/api/di/injection.dart';
import 'package:nook/api/models/nook_model.dart';
import 'package:nook/api/repositories/user_repository.dart';
import 'package:nook/features/followed_nooks_screen/bloc/followed_nooks_bloc.dart';
import 'package:nook/shared/widgets/custom_back_button.dart';
import 'package:nook/shared/widgets/error_message.dart';
import 'package:nook/shared/widgets/loading_dots.dart';
import 'package:nook/shared/widgets/nook_card.dart';
import 'package:nook/shared/widgets/nook_list.dart';
import 'package:nook/theme/colors.dart';
import 'package:nook/theme/icons.dart';

@RoutePage()
class FollowedNooksScreen extends StatefulWidget {
  const FollowedNooksScreen({super.key, this.userId});
  final String? userId;

  @override
  State<FollowedNooksScreen> createState() => _FollowedNooksScreenState();
}

class _FollowedNooksScreenState extends State<FollowedNooksScreen> {
  late final FollowedNooksBloc _followedNooksBloc;

  bool _showFloatingButton = false;
  final ScrollController _scrollController = ScrollController();

  void _onScroll() {
    final state = _followedNooksBloc.state;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (maxScroll > 650) {
      if (currentScroll > 600 && !_showFloatingButton) {
        setState(() => _showFloatingButton = true);
      } else if (currentScroll < 600 && _showFloatingButton) {
        setState(() => _showFloatingButton = false);
      }
    }

    if (state is FollowedNooksLoaded) {
      if (state.hasMore && currentScroll >= maxScroll - 200) {
        _followedNooksBloc.add(LoadFollowedNooks(offset: state.offset));
      }
    }
  }

  Future<void> _onRefresh() async {
    _followedNooksBloc.add(LoadFollowedNooks(isRefresh: true));
  }

  @override
  void initState() {
    super.initState();

    _followedNooksBloc = FollowedNooksBloc(
      userRepository: getIt<UserRepository>(),
      userId: widget.userId,
    );

    _followedNooksBloc.add(LoadFollowedNooks(isRefresh: true));

    _scrollController.addListener(() => _onScroll());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocBuilder<FollowedNooksBloc, FollowedNooksState>(
        bloc: _followedNooksBloc,
        builder: (context, state) {
          if (state is FollowedNooksLoaded) {
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
                              padding: EdgeInsets.only(
                                left: 15,
                                top: 60,
                                bottom: 25,
                              ),
                              child: CustomBackButton(color: AppColors.black),
                            ),
                            NookList(
                              nooks: state.followedNooks,
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
          } else if (state is FollowedNooksLoadingFailure) {
            return Center(child: ErrorMessage(onTap: _onRefresh));
          } else {
            return const Center(child: LoadingDots());
          }
        },
      ),
    );
  }
}
