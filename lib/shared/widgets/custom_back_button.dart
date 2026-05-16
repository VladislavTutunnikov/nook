import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nook/theme/icons.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
    this.size = 30,
    this.iconPath = AppIcons.chevronLeft,
    this.color = Colors.white,
  });

  final String iconPath;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AutoRouter.of(context).pop(),
      child: SvgPicture.asset(
        iconPath,
        width: size,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      ),
    );
  }
}
