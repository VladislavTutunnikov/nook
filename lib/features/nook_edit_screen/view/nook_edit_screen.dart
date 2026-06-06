import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nook/api/di/injection.dart';
import 'package:nook/api/models/category_model.dart';
import 'package:nook/api/models/nook_model.dart';
import 'package:nook/api/repositories/nook_repository.dart';
import 'package:nook/features/nook_edit_screen/bloc/nook_edit_bloc.dart';
import 'package:nook/features/nook_edit_screen/widgets/choose_category_button.dart';
import 'package:nook/features/nook_edit_screen/widgets/rules_form.dart';
import 'package:nook/generated/l10n.dart';
import 'package:nook/router/router.dart';
import 'package:nook/shared/widgets/avatar.dart';
import 'package:nook/shared/widgets/capsule_button.dart';
import 'package:nook/shared/widgets/edit_profile_form.dart';
import 'package:nook/shared/widgets/loading_dots.dart';
import 'package:nook/shared/widgets/network_error_dialog.dart';
import 'package:nook/theme/colors.dart';
import 'package:nook/theme/icons.dart';

@RoutePage()
class NookEditScreen extends StatefulWidget {
  const NookEditScreen({super.key, this.nook});
  final NookModel? nook;
  @override
  State<NookEditScreen> createState() => _NookEditScreenState();
}

class _NookEditScreenState extends State<NookEditScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _rulesController = TextEditingController();
  String _avatarUrl = '';
  bool _showDeleteButton = true;
  String _errorText = '';

  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;

  CategoryModel? _selectedCategory;

  late final NookEditBloc _nookEditBloc;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.nook?.name ?? '';
    _descriptionController.text = widget.nook?.description ?? '';
    _rulesController.text = widget.nook?.rules ?? '';
    _avatarUrl = widget.nook?.avatarUrl ?? '';
    _showDeleteButton = _avatarUrl.isNotEmpty;
    _selectedCategory =
        widget.nook?.categoryId != null && widget.nook?.categoryName != null
        ? CategoryModel(
            id: widget.nook!.categoryId!,
            name: widget.nook!.categoryName!,
          )
        : null;

    _nookEditBloc = NookEditBloc(
      nookRepository: getIt<NookRepository>(),
      nook: widget.nook,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    _rulesController.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    final ext = image.path.split('.').last.toLowerCase();
    if (!(['jpg', 'jpeg', 'png', 'webp'].contains(ext))) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).onlyImagesCanBeUsedForAvatar)),
      );
      return;
    }
    setState(() {
      _selectedImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<NookEditBloc, NookEditState>(
        bloc: _nookEditBloc,
        listener: (context, state) {
          if (state is AvatarDeleteSuccess) {
            setState(() {
              _avatarUrl = '';
              _showDeleteButton = _avatarUrl.isNotEmpty;
            });
          } else if (state is NameAlreadyTakenError) {
            setState(() {
              _errorText = S.of(context).nameAlreadyTakenError;
            });
          } else if (state is EmptyNameError) {
            setState(() {
              _errorText = S.of(context).emptyNameError;
            });
          } else if (state is EmptyCategoryError) {
            setState(() {
              _errorText = S.of(context).emptyCategoryError;
            });
          } else if (state is NookUpdateLoadingFailure) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const NetworkErrorDialog();
              },
            );
          } else if (state is NookUpdated) {
            AutoRouter.of(context).pop(true);
          }
        },
        child: BlocBuilder<NookEditBloc, NookEditState>(
          bloc: _nookEditBloc,
          builder: (context, state) {
            if (state is NookUpdateLoading) {
              return const Center(child: LoadingDots());
            } else {
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 60,
                            left: 20,
                            right: 20,
                          ),
                          child: Row(
                            children: [
                              CapsuleButton(
                                text: S.of(context).cancel,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                textStyle: Theme.of(
                                  context,
                                ).textTheme.titleLarge,
                                backgroundColor: AppColors.white,
                                border: BoxBorder.all(
                                  width: 1,
                                  color: AppColors.lightGrey,
                                ),
                                onTap: () => AutoRouter.of(context).pop(false),
                              ),
                              const Spacer(),
                              CapsuleButton(
                                text: S.of(context).done,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                textStyle: Theme.of(
                                  context,
                                ).textTheme.titleLarge,
                                backgroundColor: AppColors.white,
                                border: BoxBorder.all(
                                  width: 1,
                                  color: AppColors.lightGrey,
                                ),
                                onTap: () => _nookEditBloc.add(
                                  UpdateNook(
                                    name: _nameController.text,
                                    description: _descriptionController.text,
                                    rules: _rulesController.text,
                                    categoryId: _selectedCategory?.id,
                                    avatarImg: _selectedImage,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        _selectedImage == null
                            ? Stack(
                                children: [
                                  GestureDetector(
                                    onTap: _pickImage,
                                    child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Avatar(
                                        avatarUrl: _avatarUrl,
                                        size: 150,
                                      ),
                                    ),
                                  ),
                                  _showDeleteButton
                                      ? Positioned(
                                          right: 12,
                                          bottom: 12,
                                          child: GestureDetector(
                                            onTap: () => _nookEditBloc.add(
                                              DeleteAvatar(),
                                            ),
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                  66,
                                                  187,
                                                  0,
                                                  22,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ),
                                              child: Center(
                                                child: SvgPicture.asset(
                                                  AppIcons.delete,
                                                  width: 20,
                                                  colorFilter:
                                                      const ColorFilter.mode(
                                                        AppColors.darkRed,
                                                        BlendMode.srcIn,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : const SizedBox(),
                                ],
                              )
                            : GestureDetector(
                                onTap: _pickImage,
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: ClipOval(
                                    child: Image.file(
                                      File(_selectedImage!.path),
                                      width: 150,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              EditProfileForm(
                                errorText: _errorText,
                                nameController: _nameController,
                                descriptionController: _descriptionController,
                                nameHintText: S.of(context).nookName,
                                descriptionHintText: S.of(context).description,
                              ),
                              const SizedBox(height: 20),
                              RulesForm(rulesController: _rulesController),
                              const SizedBox(height: 20),
                              Align(
                                alignment: AlignmentGeometry.centerLeft,
                                child: Text(
                                  S.of(context).nookCategory,
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(color: AppColors.darkGrey),
                                ),
                              ),
                              const SizedBox(height: 5),
                              ChooseCategoryButton(
                                category: _selectedCategory,
                                onTap: () async {
                                  final category = await AutoRouter.of(context)
                                      .push<CategoryModel>(
                                        const NookCategoriesRoute(),
                                      );
                                  if (category != null) {
                                    setState(() {
                                      _selectedCategory = category;
                                    });
                                  }
                                },
                              ),
                              const SizedBox(height: 60),
                            ],
                          ),
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
