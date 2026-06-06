import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nook/theme/colors.dart';

class CapsuleButton extends StatelessWidget {
  const CapsuleButton({
    super.key,
    this.backgroundColor = AppColors.black,
    this.border,
    this.padding = const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
    this.iconPath,
    this.iconColor = AppColors.white,
    this.iconSize = 16,
    required this.text,
    this.textStyle = const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      height: 1.4,
      color: AppColors.white,
    ),
    this.onTap,
    this.centerText = false,
  });
  final EdgeInsetsGeometry? padding;
  final Color backgroundColor;
  final BoxBorder? border;
  final String? iconPath;
  final Color iconColor;
  final double iconSize;
  final String text;
  final TextStyle? textStyle;
  final void Function()? onTap;
  final bool centerText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(1000),
          border: border,
        ),
        child: Row(
          mainAxisAlignment: centerText
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            iconPath != null
                ? SvgPicture.asset(
                    iconPath!,
                    colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                    width: iconSize,
                    height: iconSize,
                  )
                : const SizedBox(),
            iconPath != null ? const SizedBox(width: 5) : const SizedBox(),
            Text(text, style: textStyle),
          ],
        ),
      ),
    );
  }
}
