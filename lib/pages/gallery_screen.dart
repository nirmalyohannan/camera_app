import 'dart:developer';
import 'dart:io';

import 'package:camera_app/functions/read_gallery.dart';
import 'package:camera_app/pages/image_viewer_screen.dart';
import 'package:flutter/material.dart';

class GalleryScreen extends StatelessWidget {
  GalleryScreen({super.key});

  List imageList = readGallery();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GridView.builder(
          itemCount: imageList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
          ),
          itemBuilder: ((context, index) {
            return GestureDetector(
              onTap: () {
                log(":::transfering to ImageViewer Screnn:::");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ImageViewerScreen(imagePath: imageList[index].path),
                    ));
              },
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(
                          File(imageList[index].path),
                        ))),
              ),
            );
          })),
    );
  }
}
