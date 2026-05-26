import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nook/api/di/injection.dart';
import 'package:nook/api/models/nook_model.dart';
import 'package:nook/api/repositories/post_repository.dart';
import 'package:nook/features/create_post_screen/bloc/create_post_bloc.dart';
import 'package:nook/features/create_post_screen/widgets/choose_nook_button.dart';
import 'package:nook/features/create_post_screen/widgets/error_dialog.dart';
import 'package:nook/features/create_post_screen/widgets/selected_images_list.dart';
import 'package:nook/features/create_post_screen/widgets/text_input_section.dart';
import 'package:nook/generated/l10n.dart';
import 'package:nook/router/router.dart';
import 'package:nook/shared/widgets/custom_back_button.dart';
import 'package:nook/shared/widgets/custom_icon_button.dart';
import 'package:nook/shared/widgets/loading_dots.dart';
import 'package:nook/theme/colors.dart';
import 'package:nook/theme/icons.dart';

@RoutePage()
class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key, this.nook});
  final NookModel? nook;
  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _textController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  List<XFile> _selectedImages = [];
  NookModel? _selectedNook;
  String? _errorMessage;

  final CreatePostBloc _createPostBloc = CreatePostBloc(
    postRepository: getIt<PostRepository>(),
  );

  Future<void> _pickImages() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    const maxImagesCount = 10;

    if (images == null) return;

    final validImages = images.where((file) {
      final ext = file.path.split('.').last.toLowerCase();
      return ['jpg', 'jpeg', 'png', 'gif', 'webp'].contains(ext);
    }).toList();

    if (validImages.length < images.length) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).youCanNotAddVideoFiles)),
      );
    }

    final currentImages = List<XFile>.from(_selectedImages);
    currentImages.addAll(validImages);

    if (currentImages.length > maxImagesCount) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).youCanSelectUpTo10Images)),
      );
    }

    final limitedImages = currentImages.take(maxImagesCount).toList();
    setState(() {
      _selectedImages = limitedImages;
    });
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
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
    _selectedNook = widget.nook;
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
      body: BlocListener<CreatePostBloc, CreatePostState>(
        bloc: _createPostBloc,
        listener: (context, state) {
          if (state is CreatePostTitleError) {
            setState(() {
              _errorMessage = S.of(context).createPostTitleErrorMessage;
            });
          } else if (state is CreatePostNookIdError) {
            setState(() {
              _errorMessage = S.of(context).createPostNookErrorMessage;
            });
          } else if (state is CreatePostFailure) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const ErrorDialog();
              },
            );
          } else if (state is PostCreated) {
            AutoRouter.of(context).pop();
          }
        },
        child: BlocBuilder<CreatePostBloc, CreatePostState>(
          bloc: _createPostBloc,
          builder: (context, state) {
            if (state is CreatePostLoading) {
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
                          onTap: () => _createPostBloc.add(
                            SendPost(
                              nookId: _selectedNook?.id,
                              title: _titleController.text,
                              content: _textController.text,
                              images: _selectedImages,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        _selectedImages.isNotEmpty
                            ? SelectedImagesList(
                                images: _selectedImages,
                                onCloseTap: _removeImage,
                              )
                            : const SizedBox(),
                        Padding(
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
