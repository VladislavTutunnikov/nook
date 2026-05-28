import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nook/theme/colors.dart';
import 'package:nook/theme/icons.dart';

class FeedHeader extends StatelessWidget {
  const FeedHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 60, bottom: 20),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: BoxBorder.all(width: 1, color: AppColors.lightGrey),
      ),
      child: Center(child: SvgPicture.asset(AppIcons.logoFilled, width: 40)),
    );
  }
}
