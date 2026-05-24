import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nook/shared/utils/formaters.dart';
import 'package:nook/shared/widgets/avatar.dart';
import 'package:nook/theme/colors.dart';
import 'package:nook/theme/icons.dart';

class PostHeader extends StatelessWidget {
  const PostHeader({
    super.key,
    this.isNook = false,
    this.onAvatarTap,
    required this.avatarUrl,
    required this.username,
    required this.createdAt,
  });
  final bool isNook;
  final void Function()? onAvatarTap;
  final String avatarUrl;
  final String username;
  final DateTime createdAt;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
        GestureDetector(
          onTap: onAvatarTap,
          child: Avatar(avatarUrl: avatarUrl),
        ),
        const SizedBox(width: 5),

        Flexible(
          child: Row(
            children: [
              SvgPicture.asset(
                isNook ? AppIcons.house : AppIcons.user,
                width: 18,
              ),
              const SizedBox(width: 2),
              Flexible(
                child: Text(
                  username,
                  style: Theme.of(context).textTheme.titleMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              const SizedBox(width: 10),
              Text(
                Formaters.formatTime(createdAt, context),
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: AppColors.darkGrey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
