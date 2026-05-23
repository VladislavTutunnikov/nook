import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nook/api/di/injection.dart';
import 'package:nook/api/repositories/nook_repository.dart';
import 'package:nook/features/member_card/widgets/member_card.dart';
import 'package:nook/features/nook_followers_screen/bloc/nook_followers_bloc.dart';
import 'package:nook/shared/widgets/custom_back_button.dart';
import 'package:nook/shared/widgets/error_message.dart';
import 'package:nook/shared/widgets/loading_dots.dart';
import 'package:nook/shared/widgets/member_list.dart';
import 'package:nook/theme/colors.dart';
import 'package:nook/theme/icons.dart';

@RoutePage()
class NookFollowersScreen extends StatefulWidget {
  const NookFollowersScreen({
    super.key,
    required this.nookId,
    this.showBanned = false,
  });
  final String nookId;
  final bool showBanned;

  @override
  State<NookFollowersScreen> createState() => _NookFollowersScreenState();
}

class _NookFollowersScreenState extends State<NookFollowersScreen> {
  late final NookFollowersBloc _nookFollowersBloc;

  bool _showFloatingButton = false;
  final ScrollController _scrollController = ScrollController();

  void _onScroll() {
    final state = _nookFollowersBloc.state;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (maxScroll > 650) {
      if (currentScroll > 600 && !_showFloatingButton) {
        setState(() => _showFloatingButton = true);
      } else if (currentScroll < 600 && _showFloatingButton) {
        setState(() => _showFloatingButton = false);
      }
    }

    if (state is NookFollowersLoaded) {
      if (state.hasMore && currentScroll >= maxScroll - 200) {
        _nookFollowersBloc.add(LoadFollowers(offset: state.offset));
      }
    }
  }

  Future<void> _onRefresh() async {
    _nookFollowersBloc.add(LoadFollowers(isRefresh: true));
  }

  @override
  void initState() {
    super.initState();
    _nookFollowersBloc = NookFollowersBloc(
      nookRepository: getIt<NookRepository>(),
      nookId: widget.nookId,
      showBanned: widget.showBanned
    );

    _nookFollowersBloc.add(LoadFollowers(isRefresh: true));

    _scrollController.addListener(() => _onScroll());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocBuilder<NookFollowersBloc, NookFollowersState>(
        bloc: _nookFollowersBloc,
        builder: (context, state) {
          if (state is NookFollowersLoaded) {
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
                                left: 25,
                                top: 60,
                                bottom: 25,
                              ),
                              child: CustomBackButton(color: AppColors.black),
                            ),
                            FollowersList(
                              followers: state.followers,
                              nookId: widget.nookId,
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
          } else if (state is NookFollowersLoadingFailure) {
            return Center(child: ErrorMessage(onTap: _onRefresh));
          } else {
            return const Center(child: LoadingDots());
          }
        },
      ),
    );
  }
}
