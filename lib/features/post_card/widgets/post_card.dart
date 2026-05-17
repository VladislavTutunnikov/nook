import 'package:auto_route/auto_route.dart';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nook/api/di/injection.dart';
import 'package:nook/api/models/post_model.dart';
import 'package:nook/api/repositories/post_repository.dart';
import 'package:nook/features/post_card/bloc/post_bloc.dart';
import 'package:nook/features/post_card/widgets/menu_bottom_sheet.dart';
import 'package:nook/features/post_card/widgets/post_header.dart';
import 'package:nook/generated/l10n.dart';
import 'package:nook/router/router.dart';
import 'package:nook/shared/utils/formaters.dart';
import 'package:nook/shared/widgets/avatar.dart';
import 'package:nook/shared/widgets/photos_list.dart';
import 'package:nook/shared/widgets/username.dart';
import 'package:nook/theme/colors.dart';
import 'package:nook/theme/icons.dart';

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
                          GestureDetector(
                            //TODO: add on menu tap
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => MenuBottomSheet(
                                  isSaved: state.isSaved,
                                  showDelete: false,
                                  showEdit: false,
                                  onSaveTap: () {
                                    Navigator.pop(context);
                                    _postBloc.add(SavePost());

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        duration: const Duration(seconds: 1),
                                        content: Text(
                                          state.isSaved
                                              ? S.of(context).postDeletedFromSaved
                                              : S.of(context).postSaved,
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
                                        content: Text(
                                          S.of(context).textCopied
                                        ),
                                      ),
                                    );
                                  },
                                  
                                  //TODO: add functionality
                                  onEditTap: null,
                                  onReportTap: null,
                                  onDeleteTap: null,

                                ),
                              );
                            },
                            child: SvgPicture.asset(AppIcons.dots, width: 22),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        //TODO: add navigation to post screen
                        onTap: null,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.post.title,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            widget.post.content != null
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      widget.post.content!,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(color: AppColors.darkGrey),
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
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

                Padding(
                  padding: const EdgeInsets.only(
                    top: 0,
                    bottom: 15,
                    left: 15,
                    right: 15,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => _postBloc.add(LikePost()),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              state.isLiked
                                  ? AppIcons.likeFilled
                                  : AppIcons.like,
                              width: 22,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              Formaters.formatNumber(state.likeCount),
                              style: Theme.of(context).textTheme.labelLarge
                                  ?.copyWith(
                                    color: state.isLiked
                                        ? AppColors.red
                                        : AppColors.black,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),

                      GestureDetector(
                        //TODO: add navigation to post screen
                        onTap: null,
                        child: Row(
                          children: [
                            SvgPicture.asset(AppIcons.comment, width: 22),
                            const SizedBox(width: 3),
                            Text(
                              Formaters.formatNumber(widget.post.commentCount),
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),

                      GestureDetector(
                        onTap: () => _postBloc.add(RepostPost()),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              state.isReposted
                                  ? AppIcons.repostChecked
                                  : AppIcons.repost,
                              width: 22,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              Formaters.formatNumber(state.repostCount),
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ],
                        ),
                      ),

                      const Spacer(),
                      widget.post.isEdited
                          ? Text(
                              S.of(context).edited,
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(color: AppColors.darkGrey),
                            )
                          : const SizedBox(),
                      const SizedBox(width: 10),
                      GestureDetector(
                        //TODO: add on share tap
                        onTap: null,
                        child: SvgPicture.asset(AppIcons.share, width: 22),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        //TODO: refactor this
        return SizedBox();
      },
    );
  }
}
