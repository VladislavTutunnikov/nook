import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nook/generated/l10n.dart';
import 'package:nook/theme/colors.dart';
import 'package:nook/theme/icons.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({
    super.key,
    this.textStyle = const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      height: 1.4,
    ),
    this.onTap,
    this.showRetryButton = true,
  });
  final TextStyle textStyle;
  final void Function()? onTap;
  final bool showRetryButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(S.of(context).somethingWentWrong, style: textStyle),
          const SizedBox(height: 10),
          showRetryButton
              ? Bounce(
                  onTap: onTap,
                  duration: const Duration(milliseconds: 100),
                  tilt: false,
                  scaleFactor: 0.9,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.lightGrey, width: 1),
                      color: AppColors.white,
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        AppIcons.rotate,
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
