import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nook/generated/l10n.dart';
import 'package:nook/theme/colors.dart';
import 'package:nook/theme/icons.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(AppIcons.logoFilled, width: 40),
        const SizedBox(height: 10),
        Text(
          S.of(context).welcomeBack,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 5),
        Text(
          S.of(context).gladToSeeYouAgain,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.darkGrey,
          ),
        ),
      ],
    );
  }
}
