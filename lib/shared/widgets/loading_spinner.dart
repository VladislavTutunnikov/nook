import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingSpinner extends StatelessWidget {
  const LoadingSpinner({super.key, this.size = 100});
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/animations/loading_spinner.json',
        width: size,
        height: size,
        frameRate: const FrameRate(60),
      ),
    );
  }
}
