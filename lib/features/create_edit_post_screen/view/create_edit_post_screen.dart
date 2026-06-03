import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nook/api/di/injection.dart';
import 'package:nook/api/models/nook_model.dart';
import 'package:nook/api/models/post_model.dart';
import 'package:nook/api/repositories/post_repository.dart';
import 'package:nook/features/create_edit_post_screen/bloc/post_form_bloc.dart';
import 'package:nook/features/create_edit_post_screen/widgets/choose_nook_button.dart';
import 'package:nook/features/create_edit_post_screen/widgets/post_loading_error_dialog.dart';
import 'package:nook/features/create_edit_post_screen/widgets/selected_images_list.dart';
import 'package:nook/features/create_edit_post_screen/widgets/text_input_section.dart';
import 'package:nook/generated/l10n.dart';
import 'package:nook/router/router.dart';
import 'package:nook/shared/widgets/custom_back_button.dart';
import 'package:nook/shared/widgets/custom_icon_button.dart';
import 'package:nook/shared/widgets/loading_dots.dart';
import 'package:nook/theme/colors.dart';
import 'package:nook/theme/icons.dart';

@RoutePage()
class CreateEditPostScreen extends StatefulWidget {
  const CreateEditPostScreen({super.key, this.nook, this.post});
  final NookModel? nook;
  final PostModel? post;
  @override
  State<CreateEditPostScreen> createState() => _CreateEditPostScreenState();
}

class _CreateEditPostScreenState extends State<CreateEditPostScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _textController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  NookModel? _selectedNook;
  String? _errorMessage;
  bool _isEdit = false;
  final String _baseUrl = getIt<String>();
  List<String> _images = [];
  final List<String> _imagesToRemove = [];

  late final PostFormBloc _postFormBloc;

  Future<void> _pickImages() async {
    final List<XFile>? selectedImages = await _picker.pickMultiImage();
    const maxImagesCount = 10;

    if (selectedImages == null) return;

    final validImages = selectedImages.where((file) {
      final ext = file.path.split('.').last.toLowerCase();
      return ['jpg', 'jpeg', 'png', 'gif', 'webp'].contains(ext);
    }).toList();

    if (validImages.length < selectedImages.length) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).youCanNotAddVideoFiles)),
      );
    }

    final availableSlots = maxImagesCount - _images.length;

    if (validImages.length > availableSlots) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).youCanSelectUpTo10Images)),
      );
    }

    final limitedImages = validImages.take(availableSlots).toList();
    setState(() {
      _images.addAll(limitedImages.map((e) => e.path).toList());
    });
  }

  void _removeImage(int index) {
    final image = _images[index];

    if (_isEdit && image.startsWith('http')) {
      _imagesToRemove.add(_images[index]);
    }

    setState(() {
      _images.removeAt(index);
    });
  }

  Future<void> _selectNook() async {
    final nook = await AutoRouter.of(
      context,
    ).push<NookModel>(FollowedNooksRoute(selectMode: true));

    if (nook != null) {
      setState(() {
        _selectedNook = nook;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _postFormBloc = PostFormBloc(
      postRepository: getIt<PostRepository>(),
      postId: widget.post?.id,
      baseUrl: _baseUrl,
    );

    _selectedNook = widget.nook;

    _isEdit = widget.post != null;

    if (_isEdit) {
      _titleController.text = widget.post!.title;
      _textController.text = widget.post!.content ?? '';
      _images = widget.post!.photos.map((url) => '$_baseUrl$url').toList();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocListener<PostFormBloc, PostFormState>(
        bloc: _postFormBloc,
        listener: (context, state) {
          if (state is PostTitleError) {
            setState(() {
              _errorMessage = S.of(context).createPostTitleErrorMessage;
            });
          } else if (state is PostNookIdError) {
            setState(() {
              _errorMessage = S.of(context).createPostNookErrorMessage;
            });
          } else if (state is PostLoadingFailure) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const PostLoadingErrorDialog();
              },
            );
          } else if (state is PostLoaded) {
            AutoRouter.of(context).pop();
          }
        },
        child: BlocBuilder<PostFormBloc, PostFormState>(
          bloc: _postFormBloc,
          builder: (context, state) {
            if (state is PostLoading) {
              return const Center(child: LoadingDots());
            } else {
              return CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    automaticallyImplyLeading: false,
                    backgroundColor: AppColors.white,
                    surfaceTintColor: AppColors.white,
                    shadowColor: AppColors.transparent,
                    title: Row(
                      children: [
                        const CustomBackButton(
                          color: AppColors.black,
                          iconPath: AppIcons.x,
                        ),
                        const Spacer(),
                        CustomIconButton(
                          iconPath: AppIcons.paperclip,
                          color: AppColors.black,
                          onTap: _pickImages,
                        ),
                        const SizedBox(width: 20),
                        CustomIconButton(
                          iconPath: AppIcons.send,
                          color: AppColors.black,
                          onTap: () => _isEdit
                              ? _postFormBloc.add(
                                  UpdatePost(
                                    title: _titleController.text,
                                    content: _textController.text,
                                    images: _images,
                                    imagesToRemove: _imagesToRemove,
                                  ),
                                )
                              : _postFormBloc.add(
                                  SendPost(
                                    nookId: _selectedNook?.id,
                                    title: _titleController.text,
                                    content: _textController.text,
                                    images: _images,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        _images.isNotEmpty
                            ? SelectedImagesList(
                                images: _images,
                                onCloseTap: _removeImage,
                              )
                            : const SizedBox(),
                        _isEdit
                            ? const SizedBox()
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 15,
                                ),
                                child: ChooseNookButton(
                                  key: ValueKey(_selectedNook?.id),
                                  avatarUrl: _selectedNook?.avatarUrl,
                                  nookName: _selectedNook?.name,
                                  onTap: _selectNook,
                                ),
                              ),

                        _errorMessage != null
                            ? Text(
                                _errorMessage!,
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(color: AppColors.darkRed),
                              )
                            : const SizedBox(),
                        TextInputSection(
                          titleController: _titleController,
                          textController: _textController,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
