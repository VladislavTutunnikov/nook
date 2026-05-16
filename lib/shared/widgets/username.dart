import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nook/theme/icons.dart';

class Username extends StatelessWidget {
  const Username({super.key, required this.username, this.isNook = false});

  final String username;
  final bool isNook;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(isNook ? AppIcons.house : AppIcons.user, width: 18),
        const SizedBox(width: 2),
        Text(
          username,
          style: Theme.of(context).textTheme.titleMedium,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
