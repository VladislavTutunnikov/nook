import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nook/generated/l10n.dart';
import 'package:nook/theme/colors.dart';

class TextInputSection extends StatelessWidget {
  const TextInputSection({
    super.key,
    required this.titleController,
    required this.textController,
  });

  final TextEditingController titleController;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: titleController,
          style: Theme.of(context).textTheme.headlineLarge,
          maxLength: 300,
          maxLines: null,
          textInputAction: TextInputAction.done,
          inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\n'))],
          decoration: InputDecoration(
            hintText: S.of(context).header,
            hintStyle: Theme.of(
              context,
            ).textTheme.headlineLarge?.copyWith(color: AppColors.darkGrey),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.transparent),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.transparent),
            ),
          ),
        ),
        TextField(
          controller: textController,
          style: Theme.of(context).textTheme.bodyLarge,
          maxLines: null,
          decoration: InputDecoration(
            hintText: S.of(context).textOptional,
            hintStyle: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: AppColors.darkGrey),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.transparent),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.transparent),
            ),
          ),
        ),
      ],
    );
  }
}
