import 'package:flutter/material.dart';
import 'package:nook/shared/widgets/avatar.dart';

class FollowingNooks extends StatelessWidget {
  const FollowingNooks({
    super.key,
    required this.followingUrls,
    required this.onTap,
  });

  final List<String> followingUrls;
  final void Function()? onTap;

  List<String> _formatListUrls(List<String> urls) {
    List<String> avatarUrls = List.from(urls);
    const maxUrlsCount = 3;

    if (avatarUrls.length < maxUrlsCount) {
      final needToAdd = maxUrlsCount - avatarUrls.length;
      for (int i = 0; i < needToAdd; i++) {
        avatarUrls.add('');
      }
    }
    return avatarUrls;
  }

  @override
  Widget build(BuildContext context) {
    final avatarUrls = _formatListUrls(followingUrls);
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 70,
        height: 40,
        child: Stack(
          children: [
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: Avatar(avatarUrl: avatarUrls[2]),
            ),
            Positioned(
              right: 15,
              top: 0,
              bottom: 0,
              child: Avatar(avatarUrl: avatarUrls[1]),
            ),
            Positioned(
              right: 30,
              top: 0,
              bottom: 0,
              child: Avatar(avatarUrl: avatarUrls[0]),
            ),
          ],
        ),
      ),
    );
  }
}
