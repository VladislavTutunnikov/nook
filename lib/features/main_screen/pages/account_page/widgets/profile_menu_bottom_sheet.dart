import 'package:flutter/material.dart';
import 'package:nook/generated/l10n.dart';
import 'package:nook/shared/widgets/text_icon_button.dart';
import 'package:nook/theme/colors.dart';
import 'package:nook/theme/icons.dart';

class ProfileMenuBottomSheet extends StatelessWidget {
  const ProfileMenuBottomSheet({
    super.key,
    this.onNooksTap,
    this.onSavedTap,
    this.onStatisticsTap,
    this.onFriendsTap,
    this.onSettingsTap,
    this.onAboutTap,
    this.onBugReportTap,
    this.onSupportTap,
    this.onLogoutTap,
  });

  final void Function()? onNooksTap;
  final void Function()? onSavedTap;
  final void Function()? onStatisticsTap;
  final void Function()? onFriendsTap;
  final void Function()? onSettingsTap;
  final void Function()? onAboutTap;
  final void Function()? onBugReportTap;
  final void Function()? onSupportTap;
  final void Function()? onLogoutTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 40, left: 25, right: 25),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.lightGrey, width: 1),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: AlignmentGeometry.center,
            child: Container(
              width: 70,
              height: 5,
              decoration: BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          const SizedBox(height: 20),

          TextIconButton(
            padding: const EdgeInsets.only(bottom: 20),
            onTap: onNooksTap,
            iconPath: AppIcons.house,
            text: S.of(context).myNooks,
          ),
          TextIconButton(
            padding: const EdgeInsets.only(bottom: 20),
            onTap: onSavedTap,
            iconPath: AppIcons.save,
            text: S.of(context).saved,
          ),
          TextIconButton(
            padding: const EdgeInsets.only(bottom: 20),
            onTap: onStatisticsTap,
            iconPath: AppIcons.statistics,
            text: S.of(context).statistics,
          ),
          TextIconButton(
            padding: const EdgeInsets.only(bottom: 20),
            onTap: onFriendsTap,
            iconPath: AppIcons.userPlus,
            text: S.of(context).inviteFriends,
          ),
          TextIconButton(
            padding: const EdgeInsets.only(bottom: 20),
            onTap: onSettingsTap,
            iconPath: AppIcons.settings,
            text: S.of(context).settings,
          ),

          const Divider(thickness: 1, height: 0, color: AppColors.lightGrey),
          const SizedBox(height: 20),

          TextIconButton(
            padding: const EdgeInsets.only(bottom: 20),
            onTap: onAboutTap,
            iconPath: AppIcons.logoIcon,
            text: S.of(context).aboutUs,
          ),
          TextIconButton(
            padding: const EdgeInsets.only(bottom: 20),
            onTap: onBugReportTap,
            iconPath: AppIcons.bug,
            text: S.of(context).reportProblem,
          ),
          TextIconButton(
            padding: const EdgeInsets.only(bottom: 20),
            onTap: onSupportTap,
            iconPath: AppIcons.question,
            text: S.of(context).contactSupport,
          ),
          TextIconButton(
            padding: const EdgeInsets.only(bottom: 20),
            onTap: onLogoutTap,
            iconPath: AppIcons.exit,
            iconColor: AppColors.darkRed,
            text: S.of(context).logout,
            textStyle: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(color: AppColors.darkRed),
          ),
        ],
      ),
    );
  }
}
