import 'package:flutter/material.dart';
import 'package:nook/generated/l10n.dart';
import 'package:nook/shared/widgets/bottom_sheet_container.dart';
import 'package:nook/shared/widgets/text_icon_button.dart';
import 'package:nook/theme/icons.dart';

class PostsFilterMenuBottomSheet extends StatelessWidget {
  const PostsFilterMenuBottomSheet({
    super.key,
    this.onPopularTap,
    this.onNewTap,
  });
  final void Function()? onPopularTap;
  final void Function()? onNewTap;
  @override
  Widget build(BuildContext context) {
    return BottomSheetContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextIconButton(
            onTap: onPopularTap,
            padding: const EdgeInsets.only(bottom: 20),
            iconPath: AppIcons.fire,
            text: S.of(context).popular,
          ),
          TextIconButton(
            onTap: onNewTap,
            padding: const EdgeInsets.only(bottom: 20),
            iconPath: AppIcons.clockArrowUp,
            text: S.of(context).fresh,
          ),
        ],
      ),
    );
  }
}
