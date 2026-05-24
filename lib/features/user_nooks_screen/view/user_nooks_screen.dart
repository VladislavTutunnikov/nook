import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nook/api/di/injection.dart';
import 'package:nook/api/repositories/user_repository.dart';
import 'package:nook/features/user_nooks_screen/bloc/user_nooks_bloc.dart';
import 'package:nook/shared/widgets/custom_back_button.dart';
import 'package:nook/shared/widgets/error_message.dart';
import 'package:nook/shared/widgets/loading_dots.dart';
import 'package:nook/shared/widgets/nook_list.dart';
import 'package:nook/theme/colors.dart';
import 'package:nook/theme/icons.dart';

@RoutePage()
class UserNooksScreen extends StatefulWidget {
  const UserNooksScreen({super.key});

  @override
  State<UserNooksScreen> createState() => _UserNooksScreenState();
}

class _UserNooksScreenState extends State<UserNooksScreen> {
  late final UserNooksBloc _userNooksBloc;

  bool _showFloatingButton = false;
  final ScrollController _scrollController = ScrollController();

  void _onScroll() {
    final state = _userNooksBloc.state;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (maxScroll > 650) {
      if (currentScroll > 600 && !_showFloatingButton) {
        setState(() => _showFloatingButton = true);
      } else if (currentScroll < 600 && _showFloatingButton) {
        setState(() => _showFloatingButton = false);
      }
    }

    if (state is UserNooksLoaded) {
      if (state.hasMore && currentScroll >= maxScroll - 200) {
        _userNooksBloc.add(LoadUserNooks(offset: state.offset));
      }
    }
  }

  Future<void> _onRefresh() async {
    _userNooksBloc.add(LoadUserNooks(isRefresh: true));
  }

  @override
  void initState() {
    super.initState();
    _userNooksBloc = UserNooksBloc(userRepository: getIt<UserRepository>());

    _userNooksBloc.add(LoadUserNooks(isRefresh: true));

    _scrollController.addListener(() => _onScroll());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocBuilder<UserNooksBloc, UserNooksState>(
        bloc: _userNooksBloc,
        builder: (context, state) {
          if (state is UserNooksLoaded) {
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
                              nooks: state.nooks,
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
          } else if (state is UserNooksLoadingFailure) {
            return Center(child: ErrorMessage(onTap: _onRefresh));
          } else {
            return const Center(child: LoadingDots());
          }
        },
      ),
    );
  }
}
