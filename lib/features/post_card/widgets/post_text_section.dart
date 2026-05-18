import 'package:flutter/material.dart';
import 'package:nook/theme/colors.dart';

class PostTextSection extends StatelessWidget {
  const PostTextSection({super.key, required this.title, this.content, this.onTap});

  final String title;
  final String? content;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //TODO: add navigation to post screen
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          content != null
              ? Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    content!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: AppColors.darkGrey),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
