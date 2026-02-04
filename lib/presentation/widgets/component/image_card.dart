import 'dart:typed_data';
import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  final Uint8List? imageData;
  final double height;
  final double width;
  final BoxFit fit;

  const ImageCard({
    super.key,
    required this.imageData,
    this.height = 120,
    this.width = double.infinity,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: imageData != null
            ? Image.memory(
                imageData!,
                fit: fit,
                errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
              )
            : _buildPlaceholder(),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Center(
      child: Icon(
        Icons.image_outlined,
        color: Colors.grey.shade400,
        size: 40,
      ),
    );
  }
}
