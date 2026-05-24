import 'package:flutter/material.dart';
import 'package:nook/generated/l10n.dart';
import 'package:nook/shared/widgets/bottom_sheet_container.dart';
import 'package:nook/shared/widgets/text_icon_button.dart';
import 'package:nook/theme/icons.dart';

class CreateMenuBottomSheet extends StatelessWidget {
  const CreateMenuBottomSheet({super.key, this.onPostTap, this.onNookTap});

  final void Function()? onPostTap;
  final void Function()? onNookTap;

  @override
  Widget build(BuildContext context) {
    return BottomSheetContainer(
      child: Column(
        children: [
          TextIconButton(
            padding: const EdgeInsets.only(bottom: 20),
            onTap: onPostTap,
            iconPath: AppIcons.commentPlus,
            text: S.of(context).createPost,
          ),
          TextIconButton(
            padding: const EdgeInsets.only(bottom: 20),
            onTap: onNookTap,
            iconPath: AppIcons.housePlus,
            text: S.of(context).createNook,
          ),
        ],
      ),
    );
  }
}
