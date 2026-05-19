import 'package:auto_route/auto_route.dart';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nook/api/di/injection.dart';
import 'package:nook/api/models/post_model.dart';
import 'package:nook/api/repositories/nook_repository.dart';
import 'package:nook/api/repositories/post_repository.dart';
import 'package:nook/api/repositories/user_repository.dart';
import 'package:nook/features/post_card/bloc/post_bloc.dart';
import 'package:nook/features/post_card/widgets/delete_post_dialog.dart';
import 'package:nook/features/post_card/widgets/post_menu_bottom_sheet.dart';
import 'package:nook/features/post_card/widgets/post_bottom_buttons.dart';
import 'package:nook/features/post_card/widgets/post_header.dart';
import 'package:nook/features/post_card/widgets/post_text_section.dart';
import 'package:nook/generated/l10n.dart';
import 'package:nook/router/router.dart';
import 'package:nook/shared/utils/formaters.dart';
import 'package:nook/shared/widgets/avatar.dart';
import 'package:nook/shared/widgets/custom_icon_button.dart';
import 'package:nook/shared/widgets/photos_list.dart';
import 'package:nook/shared/widgets/username.dart';
import 'package:nook/theme/colors.dart';
import 'package:nook/theme/icons.dart';
import 'package:share_plus/share_plus.dart';

class PostCard extends StatefulWidget {
  const PostCard({super.key, required this.post, this.showNook = false});

  final PostModel post;
  final bool showNook;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late final PostBloc _postBloc;

  @override
  void initState() {
    super.initState();
    _postBloc = PostBloc(
      postRepository: getIt<PostRepository>(),
      post: widget.post,
    );

    _postBloc.add(SetupData());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      bloc: _postBloc,
      builder: (context, state) {
        if (state is PostUpdated) {
          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(color: AppColors.lightGrey, width: 1),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: PostHeader(
                              isNook: widget.showNook,
                              avatarUrl: widget.showNook
                                  ? widget.post.nook.avatarUrl ?? ''
                                  : widget.post.user.avatarUrl ?? '',
                              username: widget.showNook
                                  ? widget.post.nook.name
                                  : widget.post.user.username,
                              onAvatarTap: () {
                                if (widget.showNook) {
                                  //TODO: add navigation to nook screen
                                } else {
                                  AutoRouter.of(context).push(
                                    AccountRoute(userId: widget.post.user.id),
                                  );
                                }
                              },
                              createdAt: widget.post.createdAt,
                            ),
                          ),

                          const SizedBox(width: 10),
                          CustomIconButton(
                            iconPath: AppIcons.dots,
                            color: AppColors.black,
                            size: 22,
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => MenuBottomSheet(
                                  isSaved: state.isSaved,
                                  isPinned: state.isPinned,
                                  showDelete: state.canDelete,
                                  showEdit: state.canEdit,
                                  showPin: state.canPin,
                                  onSaveTap: () {
                                    Navigator.pop(context);
                                    _postBloc.add(SavePost());

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        duration: const Duration(seconds: 1),
                                        content: Text(
                                          state.isSaved
                                              ? S
                                                    .of(context)
                                                    .postDeletedFromSaved
                                              : S.of(context).postSaved,
                                        ),
                                      ),
                                    );
                                  },
                                  onPinTap: () {
                                    Navigator.pop(context);
                                    _postBloc.add(PinPost());

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        duration: const Duration(seconds: 1),
                                        content: Text(
                                          state.isPinned
                                              ? S.of(context).postUnpinned
                                              : S.of(context).postPinned,
                                        ),
                                      ),
                                    );
                                  },
                                  onCopyTap: () {
                                    Navigator.pop(context);
                                    Clipboard.setData(
                                      ClipboardData(
                                        text:
                                            '${widget.post.title}\n\n${widget.post.content ?? ''}',
                                      ),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        duration: const Duration(seconds: 1),
                                        content: Text(S.of(context).textCopied),
                                      ),
                                    );
                                  },
                                  onDeleteTap: () {
                                    Navigator.pop(context);
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return DeletePostDialog(
                                          onDeleteTap: () =>
                                              _postBloc.add(DeletePost()),
                                        );
                                      },
                                    );
                                  },

                                  //TODO: add functionality
                                  onEditTap: null,
                                  onReportTap: null,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      PostTextSection(
                        title: widget.post.title,
                        content: widget.post.content,
                        //TODO: add navigation to post screen
                        onTap: null,
                      ),
                    ],
                  ),
                ),

                widget.post.photos.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: PhotosList(imgUrls: widget.post.photos),
                      )
                    : const SizedBox(),

                PostBottomButtons(
                  isLiked: state.isLiked,
                  isReposted: state.isReposted,
                  isEdited: widget.post.isEdited,

                  likeCount: state.likeCount,
                  commentCount: widget.post.commentCount,
                  repostCount: state.repostCount,

                  onLikeTap: () => _postBloc.add(LikePost()),
                  //TODO: add navigation to post screen
                  onCommentTap: null,
                  onRepostTap: () => _postBloc.add(RepostPost()),
                  //TODO: add on share tap
                  onShareTap: () => SharePlus.instance.share(
                    ShareParams(
                      text:
                          '${widget.post.title}\n\n${widget.post.content ?? ''}',
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
