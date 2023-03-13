import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LocalImage extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final double borderRadius;
  final bool progress;
  const LocalImage(this.path,
      {this.width,
      this.height,
      this.fit = BoxFit.cover,
      this.borderRadius = 0,
      this.progress = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (path.isEmpty) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(.1),
        ),
        child: const Icon(
          Icons.image,
          color: Colors.grey,
          size: 24,
        ),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: FutureBuilder(
        future: File(path).readAsBytes(),
        builder: (_, snap) {
          if (snap.hasError) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.1),
              ),
              child: const Icon(
                Icons.broken_image,
                color: Colors.grey,
                size: 24,
              ),
            );
          }
          if (!snap.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Image.memory(
            snap.data as Uint8List,
            fit: fit,
            height: height,
            width: width,
          );
        },
      ),
    );
  }
}
