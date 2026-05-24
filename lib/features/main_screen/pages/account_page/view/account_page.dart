import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nook/api/di/injection.dart';
import 'package:nook/api/models/user_model.dart';
import 'package:nook/api/repositories/auth_repository.dart';
import 'package:nook/api/repositories/user_repository.dart';
import 'package:nook/features/main_screen/pages/account_page/bloc/account_bloc/account_bloc.dart';
import 'package:nook/features/main_screen/pages/account_page/bloc/content_bloc/content_bloc.dart';
import 'package:nook/features/main_screen/pages/account_page/widgets/account_header.dart';
import 'package:nook/features/main_screen/pages/account_page/widgets/comment_list.dart';
import 'package:nook/features/main_screen/pages/account_page/widgets/create_menu_bottom_sheet.dart';
import 'package:nook/shared/widgets/post_list.dart';
import 'package:nook/features/main_screen/pages/account_page/widgets/profile_menu_bottom_sheet.dart';
import 'package:nook/features/main_screen/pages/account_page/widgets/tab_header.dart';
import 'package:nook/features/main_screen/pages/account_page/widgets/profile_bio.dart';
import 'package:nook/generated/l10n.dart';
import 'package:nook/router/router.dart';
import 'package:nook/shared/widgets/error_message.dart';
import 'package:nook/shared/widgets/loading_dots.dart';
import 'package:nook/theme/colors.dart';
import 'package:nook/theme/icons.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key, this.userId});
  final String? userId;

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  int _currentIndex = 0;
  bool _showFloatingButton = false;
  late final bool _isOwnerProfile;

  final ScrollController _scrollController = ScrollController();

  late final AccountBloc _accountBloc;
  late final ContentBloc _contentBloc;

  @override
  void initState() {
    _accountBloc = AccountBloc(
      userRepository: getIt<UserRepository>(),
      authRepository: getIt<AuthRepository>(),
      userId: widget.userId,
    );
    _contentBloc = ContentBloc(
      userRepository: getIt<UserRepository>(),
      userId: widget.userId,
    );

    _accountBloc.add(LoadAccountData());
    _contentBloc.add(LoadPosts());

    _scrollController.addListener(() => _onScroll(_currentIndex));

    _isOwnerProfile = widget.userId == null;
    super.initState();
  }

  @override
  void dispose() {
    _accountBloc.close();
    _contentBloc.close();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    final completer = Completer();
    _accountBloc.add(LoadAccountData(completer: completer));
    _onTabChanged(_currentIndex, isRefresh: true);
    await completer.future;
  }

  void _onTabChanged(int index, {bool isRefresh = false}) {
    if (!isRefresh && _currentIndex == index) return;
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        _contentBloc.add(LoadPosts(isRefresh: isRefresh));
        break;
      case 1:
        _contentBloc.add(LoadComments(isRefresh: isRefresh));
        break;
      case 2:
        _contentBloc.add(LoadReposts(isRefresh: isRefresh));
        break;
      case 3:
        _contentBloc.add(LoadLikes(isRefresh: isRefresh));
        break;
    }
  }

  Widget _buildTabContent(int index, UserModel user) {
    if (index == 4) {
      return ProfileBio(text: user.bio);
    }
    return BlocBuilder<ContentBloc, ContentState>(
      bloc: _contentBloc,
      builder: (context, state) {
        if (state is PostsLoaded) {
          return PostList(
            posts: state.posts,
            showNook: true,
            showLoading: state.hasMore,
          );
        } else if (state is CommentsLoaded) {
          return CommentList(
            comments: state.comments,
            showLoading: state.hasMore,
          );
        }
        return ErrorMessage(onTap: _onRefresh);
      },
    );
  }

  void _onScroll(int index) {
    final state = _contentBloc.state;

    bool hasMore = false;
    int offset = 0;
    if (state is PostsLoaded) {
      hasMore = state.hasMore;
      offset = state.offset;
    } else if (state is CommentsLoaded) {
      hasMore = state.hasMore;
      offset = state.offset;
    }

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (maxScroll > 650) {
      if (currentScroll > 600 && !_showFloatingButton) {
        setState(() => _showFloatingButton = true);
      } else if (currentScroll < 600 && _showFloatingButton) {
        setState(() => _showFloatingButton = false);
      }
    }

    if (hasMore && currentScroll >= maxScroll - 200) {
      switch (index) {
        case 0:
          _contentBloc.add(LoadPosts(offset: offset));
          break;
        case 1:
          _contentBloc.add(LoadComments(offset: offset));
          break;
        case 2:
          _contentBloc.add(LoadReposts(offset: offset));
          break;
        case 3:
          _contentBloc.add(LoadLikes(offset: offset));
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      bloc: _accountBloc,
      builder: (context, state) {
        if (state is AccountLoaded) {
          final user = state.user;
          final followingUrls = state.followingUrls;
          return Stack(
            children: [
              RefreshIndicator(
                color: AppColors.black,
                onRefresh: _onRefresh,
                child: CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: _scrollController,
                  slivers: [
                    SliverToBoxAdapter(
                      child: AccountHeader(
                        isOwnerProfile: _isOwnerProfile,
                        user: user,
                        followingUrls: followingUrls,
                        //TODO: add navigation to follows screen
                        onFollowingTap: () => AutoRouter.of(context).push(FollowedNooksRoute(userId: widget.userId)),
                        onPlusTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => const CreateMenuBottomSheet(
                              //TODO: add functionality
                              onPostTap: null,
                              onNookTap: null,
                            ),
                          );
                        },
                        //TODO: add navigation to edit profile screen
                        onEditTap: null,
                        onMenuTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => ProfileMenuBottomSheet(
                              onNooksTap: () {
                                Navigator.pop(context);
                                AutoRouter.of(
                                  context,
                                ).push(const UserNooksRoute());
                              },
                              onSavedTap: () {
                                Navigator.pop(context);
                                AutoRouter.of(
                                  context,
                                ).push(const SavedPostsRoute());
                              },
                              //TODO: add functionality
                              onStatisticsTap: null,
                              onFriendsTap: null,
                              onSettingsTap: null,
                              onAboutTap: null,
                              onBugReportTap: null,
                              onSupportTap: null,
                              onLogoutTap: () {
                                //TODO: add logout dialog
                                Navigator.pop(context);
                                _accountBloc.add(Logout(context));
                              },
                            ),
                          );
                        },
                      ),
                    ),

                    SliverToBoxAdapter(
                      child: TabHeader(
                        tabs: [
                          S.of(context).posts,
                          S.of(context).comments,
                          S.of(context).reposts,
                          S.of(context).likes,
                          S.of(context).description,
                        ],
                        currentIndex: _currentIndex,
                        onTap: _onTabChanged,
                      ),
                    ),

                    SliverToBoxAdapter(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: _buildTabContent(_currentIndex, user),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 10,
                bottom: _isOwnerProfile ? 10 : 40,
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
        } else if (state is AccountLoadFailure) {
          return Center(child: ErrorMessage(onTap: _onRefresh));
        } else {
          return const Center(child: LoadingDots());
        }
      },
    );
  }
}
