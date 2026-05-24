import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nook/api/models/nook_model.dart';
import 'package:nook/router/router.dart';
import 'package:nook/shared/widgets/avatar.dart';
import 'package:nook/theme/colors.dart';
import 'package:nook/theme/icons.dart';

class NookCard extends StatelessWidget {
  const NookCard({super.key, required this.nook});
  final NookModel nook;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.lightGrey, width: 1),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () =>
                  AutoRouter.of(context).push(NookRoute(nookId: nook.id)),
              child: Row(
                children: [
                  Avatar(avatarUrl: nook.avatarUrl ?? ''),
                  const SizedBox(width: 10),
                  SvgPicture.asset(AppIcons.house, width: 18),
                  const SizedBox(width: 2),
                  Expanded(
                    child: Text(
                      nook.name,
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
