import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:nook/api/di/injection.dart';
import 'package:nook/theme/colors.dart';

class BackgroundBlurImage extends StatelessWidget {
  const BackgroundBlurImage({
    super.key,
    required this.imgUrl,
    required this.child,
  });

  final String imgUrl;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final baseUrl = getIt<String>();
    return Stack(
      children: [
        Blur(
          blur: 40,
          blurColor: AppColors.transparent,
          colorOpacity: 0.13,
          child: FadeInImage.assetNetwork(
            key: ValueKey(imgUrl),
            placeholder: 'assets/images/avatar.png',
            image: '$baseUrl$imgUrl',
            width: screenWidth,
            height: screenHeight / 2,
            fit: BoxFit.cover,
            imageErrorBuilder: (context, error, stackTrace) {
              return Image.asset(
                'assets/images/avatar.png',
                width: screenWidth,
                height: screenHeight / 2,
                fit: BoxFit.cover,
              );
            },
          ),
        ),

        Container(
          width: double.infinity,
          height: screenHeight / 2,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.5, 0.9],
              colors: [AppColors.transparent, AppColors.black],
            ),
          ),
          child: child,
        ),
      ],
    );
  }
}
