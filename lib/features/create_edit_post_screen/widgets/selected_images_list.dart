import 'package:flutter/material.dart';
import 'package:nook/features/create_edit_post_screen/widgets/selected_image.dart';

class SelectedImagesList extends StatelessWidget {
  const SelectedImagesList({super.key, required this.images, this.onCloseTap});

  final List<String> images;
  final void Function(int)? onCloseTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) => SelectedImage(
          path: images[index],
          onCloseTap: () => onCloseTap?.call(index),
        ),
      ),
    );
  }
}
