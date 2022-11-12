import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:camera_app/functions/read_gallery.dart';
import 'package:camera_app/main.dart';
import 'package:camera_app/pages/gallery_screen.dart';
import 'package:camera_app/pages/image_viewer_screen.dart';
import 'package:flutter/material.dart';

import '../functions/save_image.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController controllerCamera =
      CameraController(cameraSelected, ResolutionPreset.ultraHigh);
  late Future controllerCameraInitialised;
  XFile? image;

  @override
  void initState() {
    controllerCameraInitialised = controllerCamera.initialize();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controllerCamera.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: FutureBuilder(
          future: controllerCameraInitialised,
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.done
                ? CameraView()
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }

  Widget CameraView() {
    return Center(
      child: Container(
        color: Colors.black,
        padding: const EdgeInsets.all(10),
        child: Stack(
          children: [
            CameraPreview(controllerCamera),
            Container(
              alignment: Alignment.bottomCenter,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        //CameraRotate button
                        iconSize: 60,
                        onPressed: () {
                          cameraSelected == cameras.first
                              ? cameraSelected = cameras.last
                              : cameraSelected = cameras.first;
                          controllerCamera.dispose();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => const CameraScreen())),
                              (route) => false);
                        },
                        icon: const Icon(
                          Icons.camera_front,
                          color: Colors.white,
                        )),

                    ///--------------------------//
                    IconButton(
                      //Picture Capture Button
                      iconSize: 80,
                      onPressed: () async {
                        try {
                          image = await controllerCamera.takePicture();

                          saveImage(image!);

                          setState(() {}); //reloads the page
                        } catch (e) {
                          print(e);
                        }
                      },
                      icon: const Icon(
                        Icons.circle,
                        color: Colors.white,
                      ),
                    ),

                    ///--------------------------//
                    CircleAvatar(
                      //Last Photo Preview
                      radius: 40,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: readGallery().isNotEmpty
                              ? GestureDetector(
                                  onTap: () {
                                    readGallery();

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => GalleryScreen(),
                                        ));
                                  },
                                  child: Image.file(
                                    File(readGallery().last.path),
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ))
                              : Container(
                                  child: Text("waiting for image"),
                                )),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
