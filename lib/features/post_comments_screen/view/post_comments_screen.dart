import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nook/api/di/injection.dart';
import 'package:nook/api/models/post_model.dart';
import 'package:nook/api/repositories/post_repository.dart';
import 'package:nook/features/post_card/widgets/post_card.dart';
import 'package:nook/features/post_comments_screen/bloc/create_comment_bloc/create_comment_bloc.dart';
import 'package:nook/features/post_comments_screen/bloc/post_comments_bloc/post_comments_bloc.dart';
import 'package:nook/features/post_comments_screen/widgets/comment_form.dart';
import 'package:nook/features/post_comments_screen/widgets/thread_comment_list.dart';
import 'package:nook/shared/widgets/custom_back_button.dart';
import 'package:nook/shared/widgets/error_message.dart';
import 'package:nook/shared/widgets/loading_dots.dart';
import 'package:nook/shared/widgets/network_error_dialog.dart';
import 'package:nook/theme/colors.dart';

@RoutePage()
class PostCommentsScreen extends StatefulWidget {
  const PostCommentsScreen({super.key, required this.post});
  final PostModel post;

  @override
  State<PostCommentsScreen> createState() => _PostCommentsScreenState();
}

class _PostCommentsScreenState extends State<PostCommentsScreen> {
  final TextEditingController _commentController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _showSendButton = false;
  bool _isFieldFocused = false;

  final ScrollController _scrollController = ScrollController();

  late final PostCommentsBloc _postCommentsBloc;
  late final CreateCommentBloc _createCommentBloc;

  Future<void> _onRefresh() async {
    _postCommentsBloc.add(LoadPostComments(isRefresh: true));
  }

  void _onScroll() {
    final state = _postCommentsBloc.state;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (state is PostCommentsLoaded) {
      if (state.hasMore && currentScroll >= maxScroll - 200) {
        _postCommentsBloc.add(LoadPostComments(offset: state.offset));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _postCommentsBloc = PostCommentsBloc(
      postRepository: getIt<PostRepository>(),
      post: widget.post,
    );

    _postCommentsBloc.add(LoadPostComments(isRefresh: true));

    _createCommentBloc = CreateCommentBloc(
      postRepository: getIt<PostRepository>(),
      postId: widget.post.id,
    );

    _commentController.addListener(() {
      setState(() {
        _showSendButton = _commentController.text.trim().isNotEmpty;
      });
    });

    _focusNode.addListener(() {
      setState(() {
        _isFieldFocused = _focusNode.hasFocus;
      });
    });

    _scrollController.addListener(() => _onScroll());
  }

  @override
  void dispose() {
    super.dispose();
    _commentController.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocListener<CreateCommentBloc, CreateCommentState>(
        bloc: _createCommentBloc,
        listener: (context, state) {
          if (state is CreateCommentLoaded) {
            _postCommentsBloc.add(LoadPostComments(isRefresh: true));
            _focusNode.unfocus();
            _commentController.text = '';
          } else if (state is CreateCommentLoadingFailure) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const NetworkErrorDialog();
              },
            );
          }
        },
        child: BlocBuilder<PostCommentsBloc, PostCommentsState>(
          bloc: _postCommentsBloc,
          builder: (context, state) {
            if (state is PostCommentsLoaded) {
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
                                padding: EdgeInsets.only(top: 60, left: 10),
                                child: CustomBackButton(color: AppColors.black),
                              ),
                              PostCard(
                                post: widget.post,
                                borderRadius: 0,
                                border: const Border(
                                  bottom: BorderSide(
                                    color: AppColors.lightGrey,
                                    width: 1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: ThreadCommentList(
                            comments: state.comments,
                            showLoading: state.hasMore,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: CommentForm(
                      commentController: _commentController,
                      focusNode: _focusNode,
                      isFocused: _isFieldFocused,
                      showSendButton: _showSendButton,
                      onSendTap: () {
                        _createCommentBloc.add(
                          CreateComment(content: _commentController.text),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (state is PostCommentsLoadingFailure) {
              return Center(child: ErrorMessage(onTap: _onRefresh));
            } else {
              return const Center(child: LoadingDots());
            }
          },
        ),
      ),
    );
  }
}
