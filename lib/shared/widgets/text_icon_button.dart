import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nook/theme/colors.dart';

class TextIconButton extends StatelessWidget {
  const TextIconButton({
    super.key,
    required this.iconPath,
    this.iconColor = AppColors.black,
    this.iconSize = 24,
    required this.text,
    this.textStyle = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      height: 1.3,
    ),
    this.onTap,
    this.padding = const EdgeInsets.all(0),
    this.gap = 10,
    this.isExpanded = true,
  });

  final String? iconPath;
  final Color iconColor;
  final double iconSize;
  final String text;
  final TextStyle? textStyle;
  final void Function()? onTap;
  final EdgeInsetsGeometry padding;
  final double gap;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            iconPath != null
                ? SvgPicture.asset(
                    iconPath!,
                    width: iconSize,
                    height: iconSize,
                    colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                  )
                : const SizedBox(),
            SizedBox(width: gap),
            isExpanded
                ? Expanded(child: Text(text, style: textStyle))
                : Text(text, style: textStyle),
          ],
        ),
      ),
    );
  }
}
