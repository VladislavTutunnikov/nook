import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nook/api/di/injection.dart';
import 'package:nook/api/models/user_model.dart';
import 'package:nook/api/repositories/user_repository.dart';
import 'package:nook/features/user_profile_edit_screen/bloc/user_edit_bloc.dart';
import 'package:nook/shared/widgets/edit_profile_form.dart';
import 'package:nook/generated/l10n.dart';
import 'package:nook/shared/widgets/avatar.dart';
import 'package:nook/shared/widgets/capsule_button.dart';
import 'package:nook/shared/widgets/loading_dots.dart';
import 'package:nook/shared/widgets/network_error_dialog.dart';
import 'package:nook/theme/colors.dart';
import 'package:nook/theme/icons.dart';

@RoutePage()
class UserProfileEditScreen extends StatefulWidget {
  const UserProfileEditScreen({super.key, required this.user});

  final UserModel user;

  @override
  State<UserProfileEditScreen> createState() => _UserProfileEditScreenState();
}

class _UserProfileEditScreenState extends State<UserProfileEditScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  String _avatarUrl = '';
  bool _showDeleteButton = true;
  String _errorText = '';

  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;

  late final UserEditBloc _userEditBloc;

  @override
  void initState() {
    super.initState();
    _usernameController.text = widget.user.username;
    _bioController.text = widget.user.bio ?? '';
    _avatarUrl = widget.user.avatarUrl ?? '';
    _showDeleteButton = _avatarUrl.isNotEmpty;

    _userEditBloc = UserEditBloc(
      userRepository: getIt<UserRepository>(),
      user: widget.user,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _bioController.dispose();
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
      body: BlocListener<UserEditBloc, UserEditState>(
        bloc: _userEditBloc,
        listener: (context, state) {
          if (state is AvatarDeleteSuccess) {
            setState(() {
              _avatarUrl = '';
              _showDeleteButton = _avatarUrl.isNotEmpty;
            });
          } else if (state is UsernameAlreadyTakenError) {
            setState(() {
              _errorText = S.of(context).usernameAlreadyTakenError;
            });
          } else if (state is EmptyUsernameError) {
            setState(() {
              _errorText = S.of(context).emptyUsernameError;
            });
          } else if (state is UserProfileUpdateLoadingFailure) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const NetworkErrorDialog();
              },
            );
          } else if (state is UserProfileUpdated) {
            AutoRouter.of(context).pop(true);
          }
        },
        child: BlocBuilder<UserEditBloc, UserEditState>(
          bloc: _userEditBloc,
          builder: (context, state) {
            if (state is UserProfileUpdateLoading) {
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
                                onTap: () => _userEditBloc.add(
                                  UpdateProfile(
                                    username: _usernameController.text,
                                    bio: _bioController.text,
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
                                            onTap: () => _userEditBloc.add(
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
                          child: EditProfileForm(
                            errorText: _errorText,
                            nameController: _usernameController,
                            descriptionController: _bioController,
                            nameHintText: S.of(context).username,
                            descriptionHintText: S.of(context).bio,
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
