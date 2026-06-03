import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nook/theme/colors.dart';
import 'package:nook/theme/icons.dart';

class SelectedImage extends StatelessWidget {
  const SelectedImage({super.key, required this.path, this.onCloseTap});

  final String path;
  final void Function()? onCloseTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(20),
          child: path.startsWith('http')
              ? Image.network(
                  path,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/photo_placeholder.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    );
                  },
                )
              : Image.file(
                  File(path),
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
        ),

        Positioned(
          right: 5,
          top: 5,
          child: GestureDetector(
            onTap: onCloseTap,
            child: Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1000),
                color: const Color.fromARGB(118, 0, 0, 0),
              ),
              child: Center(
                child: SvgPicture.asset(
                  AppIcons.x,
                  colorFilter: ColorFilter.mode(
                    AppColors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
