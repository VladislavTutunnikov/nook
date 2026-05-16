import 'package:flutter/material.dart';
import 'package:fullscreen_image_viewer/fullscreen_image_viewer.dart';
import 'package:nook/api/di/injection.dart';

class PhotosList extends StatelessWidget {
  const PhotosList({super.key, required this.imgUrls});

  final List<String> imgUrls;

  @override
  Widget build(BuildContext context) {
    final baseUrl = getIt<String>();
    return SizedBox(
      height: 250,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: imgUrls.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              FullscreenImageViewer.open(
                context: context,
                child: Image.network(
                  '$baseUrl${imgUrls[index]}',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/photo_placeholder.png',
                      fit: BoxFit.cover,
                    );
                  },
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(15),
                child: Image.network(
                  '$baseUrl${imgUrls[index]}',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/photo_placeholder.png',
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
