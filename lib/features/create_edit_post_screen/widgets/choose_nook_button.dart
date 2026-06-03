import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nook/generated/l10n.dart';
import 'package:nook/shared/widgets/avatar.dart';
import 'package:nook/theme/icons.dart';

class ChooseNookButton extends StatelessWidget {
  const ChooseNookButton({
    super.key,
    this.onTap,
    this.avatarUrl,
    this.nookName,
  });

  final String? avatarUrl;
  final String? nookName;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Avatar(
            avatarUrl: avatarUrl ?? '',
            placeholderImagePath: 'assets/images/nook_avatar.png',
          ),
          const SizedBox(width: 5),
          Text(
            nookName ?? S.of(context).chooseNook,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(width: 2),
          SvgPicture.asset(AppIcons.chevronsUpDown, width: 20, height: 20),
        ],
      ),
    );
  }
}
