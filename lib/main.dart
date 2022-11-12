import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:camera_app/pages/camera_screen.dart';
import 'package:camera_app/pages/permission_screen.dart';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

late final List<CameraDescription> cameras;
late bool cameraPermissionStatus;
late CameraDescription cameraSelected;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.camera.status.isGranted &&
          await Permission.microphone.status.isGranted &&
          await Permission.storage.status.isGranted
      ? cameraPermissionStatus = true
      : cameraPermissionStatus = false;
  log("::::::::::::::::::Camera permission::$cameraPermissionStatus");
  cameras = await availableCameras();
  log("Number of cameras : ${cameras.length}");
  cameraSelected = cameras.first;
  runApp(const CameraApp());
}

class CameraApp extends StatelessWidget {
  const CameraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: cameraPermissionStatus == true
          ? const CameraScreen()
          : const PermissionScreen(),
    );
  }
}
