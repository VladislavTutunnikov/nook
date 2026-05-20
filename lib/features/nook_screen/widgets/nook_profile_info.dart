import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nook/shared/utils/formaters.dart';
import 'package:nook/shared/widgets/avatar.dart';
import 'package:nook/theme/colors.dart';
import 'package:nook/theme/icons.dart';

class NookProfileInfo extends StatelessWidget {
  const NookProfileInfo({
    super.key,
    required this.avatarUrl,
    required this.name,
    required this.followersCount,
    this.onTap,
  });
  final String avatarUrl;
  final String name;
  final int followersCount;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Avatar(size: 50, avatarUrl: avatarUrl),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  children: [
                    SvgPicture.asset(AppIcons.house, width: 20),
                    const SizedBox(width: 5),
                    Text(name, style: Theme.of(context).textTheme.titleLarge),
                  ],
                ),
              ),
              const SizedBox(height: 3),
              Row(
                children: [
                  SvgPicture.asset(
                    AppIcons.users,
                    width: 20,
                    colorFilter: const ColorFilter.mode(
                      AppColors.darkGrey,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    Formaters.formatNumber(followersCount),
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge?.copyWith(color: AppColors.darkGrey),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
