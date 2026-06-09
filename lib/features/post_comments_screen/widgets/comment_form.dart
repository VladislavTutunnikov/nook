import 'package:flutter/material.dart';
import 'package:nook/generated/l10n.dart';
import 'package:nook/shared/widgets/custom_icon_button.dart';
import 'package:nook/theme/colors.dart';
import 'package:nook/theme/icons.dart';

class CommentForm extends StatelessWidget {
  const CommentForm({
    super.key,
    this.commentController,
    required this.showSendButton,
    this.onSendTap,
    required this.isFocused,
    this.focusNode,
  });
  final TextEditingController? commentController;
  final bool showSendButton;
  final void Function()? onSendTap;
  final FocusNode? focusNode;
  final bool isFocused;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 30,
        left: 20,
        right: 20,
        top: 20,
      ),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        border: Border(top: BorderSide(color: AppColors.lightGrey, width: 1)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: commentController,
              focusNode: focusNode,
              style: Theme.of(context).textTheme.bodyLarge,
              maxLines: 8,
              minLines: 1,
              scrollPhysics: const BouncingScrollPhysics(),
              decoration: InputDecoration(
                filled: !isFocused,
                fillColor: AppColors.lightGrey,
                hintText: S.of(context).writeComment,
                hintStyle: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: AppColors.darkGrey),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.transparent),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.lightGrey),
                ),
              ),
            ),
          ),
          showSendButton
              ? Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: CustomIconButton(
                    iconPath: AppIcons.send,
                    color: AppColors.black,
                    onTap: onSendTap,
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
