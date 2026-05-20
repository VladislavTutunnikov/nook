import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nook/generated/l10n.dart';
import 'package:nook/theme/icons.dart';

class PinnedPostList extends StatelessWidget {
  const PinnedPostList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            children: [
              SvgPicture.asset(AppIcons.pin, width: 16),
              const SizedBox(width: 5),
              Text(
                S.of(context).pinned,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
        //TODO: add list view
      ],
    );
  }
}
