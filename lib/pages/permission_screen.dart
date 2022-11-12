import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:camera_app/main.dart';
import 'package:camera_app/pages/camera_screen.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionScreen extends StatefulWidget {
  const PermissionScreen({super.key});

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            child: const Text("Give Camera Permission"),
            onPressed: () async {
              await Permission.camera.request();
              await Permission.microphone.request();
              await Permission.storage.request();

              log("Asked permission");

              if (await Permission.camera.status.isGranted &&
                  await Permission.microphone.status.isGranted &&
                  await Permission.storage.status.isGranted) {
                const SnackBar(content: Text("Camera permission granted"));

                // ignore: use_build_context_synchronously
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CameraScreen(),
                    ),
                    (route) => false);
              } else {
                snackBar(
                    "Permissions have been denied :( \nGrant permission from Settings");
                await Future.delayed(const Duration(seconds: 2));
                openAppSettings();
              }
            }),
      ),
    );
  }

  snackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}
