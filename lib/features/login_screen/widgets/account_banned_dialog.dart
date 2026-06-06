import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nook/generated/l10n.dart';
import 'package:nook/shared/widgets/text_icon_button.dart';
import 'package:nook/theme/colors.dart';
import 'package:nook/theme/icons.dart';

class AccountBannedDialog extends StatefulWidget {
  const AccountBannedDialog({super.key});

  @override
  State<AccountBannedDialog> createState() => _AccountBannedDialogState();
}

class _AccountBannedDialogState extends State<AccountBannedDialog> {
  bool _copied = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              AppIcons.ban,
              width: 50,
              colorFilter: ColorFilter.mode(AppColors.darkRed, BlendMode.srcIn),
            ),
            const SizedBox(height: 10),
            Text(
              S.of(context).yourAccountHasBeenBanned,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(color: AppColors.darkRed),
            ),
            const SizedBox(height: 10),
            Text(
              S.of(context).contactSupportIfMistake,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Spacer(),
                TextIconButton(
                  onTap: () {
                    Clipboard.setData(
                      const ClipboardData(text: 'nook-support@gmail.com'),
                    );
                    setState(() {
                      _copied = true;
                    });
                  },
                  isExpanded: false,
                  iconPath: _copied ? AppIcons.circleCheck : AppIcons.copy,
                  iconSize: 18,
                  //TODO: replace with real email
                  text: 'nook-support@gmail.com',
                  textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                    decoration: TextDecoration.underline,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
