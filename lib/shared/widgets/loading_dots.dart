import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingDots extends StatelessWidget {
  const LoadingDots({super.key, this.size = 80});
  final double size;

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/animations/loading_dots.json',
      width: size,
      height: size,
      frameRate: const FrameRate(60),
    );
  }
}
