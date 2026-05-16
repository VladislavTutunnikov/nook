import 'package:flutter/material.dart';
import 'package:nook/generated/l10n.dart';
import 'package:nook/theme/colors.dart';

class ProfileBio extends StatelessWidget {
  const ProfileBio({super.key, this.text});

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: BorderDirectional(
          bottom: BorderSide(color: AppColors.lightGrey, width: 1),
        ),
      ),
      child: SelectableText(
        text == null || text == '' ? S.of(context).theresNothingHere : text!,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
