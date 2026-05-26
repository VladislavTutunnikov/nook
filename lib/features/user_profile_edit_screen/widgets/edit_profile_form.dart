import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nook/generated/l10n.dart';
import 'package:nook/theme/colors.dart';

class EditProfileForm extends StatelessWidget {
  const EditProfileForm({
    super.key,
    this.usernameController,
    this.bioController,
    required this.errorText,
  });

  final TextEditingController? usernameController;
  final TextEditingController? bioController;
  final String errorText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: BoxBorder.all(width: 1, color: AppColors.lightGrey),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          TextField(
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9_.-]')),
              FilteringTextInputFormatter.deny(RegExp(r'\s')),
            ],
            controller: usernameController,

            maxLength: 50,
            buildCounter:
                (
                  context, {
                  required currentLength,
                  required isFocused,
                  maxLength,
                }) => const SizedBox(),
            style: Theme.of(context).textTheme.titleMedium,
            decoration: InputDecoration(
              hintText: S.of(context).username,
              hintStyle: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: AppColors.darkGrey),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.transparent),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.transparent),
              ),
            ),
          ),
          errorText.isNotEmpty
              ? Text(
                  errorText,
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: AppColors.darkRed),
                )
              : const SizedBox(),
          const Divider(thickness: 1, color: AppColors.lightGrey),
          TextField(
            controller: bioController,
            style: Theme.of(context).textTheme.titleMedium,
            maxLines: null,
            decoration: InputDecoration(
              hintText: S.of(context).bio,
              hintStyle: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: AppColors.darkGrey),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.transparent),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.transparent),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
