import 'package:flutter/material.dart';
import 'package:nook/generated/l10n.dart';
import 'package:nook/shared/widgets/capsule_button.dart';
import 'package:nook/theme/icons.dart';

class NookHeaderButtons extends StatelessWidget {
  const NookHeaderButtons({
    super.key,
    this.onCreatePostTap,
    this.onRulesTap,
    this.onTeamTap,
    this.onStatisticsTap,
    this.onBannedTap,
    this.showBanned = false,
  });
  final void Function()? onCreatePostTap;
  final void Function()? onRulesTap;
  final void Function()? onBannedTap;
  final void Function()? onStatisticsTap;
  final void Function()? onTeamTap;
  final bool showBanned;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          const SizedBox(width: 20),
          CapsuleButton(
            onTap: onCreatePostTap,
            iconPath: AppIcons.plus,
            text: S.of(context).createPost,
          ),
          const SizedBox(width: 10),
          CapsuleButton(
            onTap: onRulesTap,
            iconPath: AppIcons.scales,
            text: S.of(context).rules,
          ),
          const SizedBox(width: 10),
          //TODO: add statistics button
          // CapsuleButton(
          //   onTap: onStatisticsTap,
          //   iconPath: AppIcons.statistics,
          //   text: S.of(context).statistics,
          // ),
          // const SizedBox(width: 10),
          showBanned
              ? CapsuleButton(
                  onTap: onBannedTap,
                  iconPath: AppIcons.ban,
                  text: S.of(context).inBan,
                )
              : const SizedBox(),
          showBanned ? const SizedBox(width: 10) : const SizedBox(),
          CapsuleButton(
            onTap: onTeamTap,
            iconPath: AppIcons.sparkle,
            text: S.of(context).team,
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}
