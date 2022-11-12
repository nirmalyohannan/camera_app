import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewerScreen extends StatelessWidget {
  final String imagePath;
  const ImageViewerScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: PhotoView(
        imageProvider: FileImage(File(imagePath)),
        minScale: 0.18,
        maxScale: 2.0,
      )),
    ));
  }
}
