import 'package:flutter/material.dart';
import 'package:nook/api/di/injection.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    super.key,
    required this.avatarUrl,
    this.size = 40,
    this.placeholderImagePath = 'assets/images/avatar.png',
  });
  final String avatarUrl;
  final String placeholderImagePath;
  final double size;

  @override
  Widget build(BuildContext context) {
    final baseUrl = getIt<String>();
    return ClipOval(
      child: FadeInImage.assetNetwork(
        placeholder: placeholderImagePath,
        image: '$baseUrl$avatarUrl',
        width: size,
        height: size,
        fit: BoxFit.cover,
        imageErrorBuilder: (context, error, stackTrace) {
          return ClipOval(
            child: Image.asset(
              placeholderImagePath,
              width: size,
              height: size,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
