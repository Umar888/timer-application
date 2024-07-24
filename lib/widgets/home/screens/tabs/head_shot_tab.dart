import 'package:camera_macos/camera_macos.dart';
import 'package:camera_universal/camera_universal.dart';
import 'package:flutter/material.dart';

class HeadshotTab extends StatefulWidget {

  HeadshotTab({super.key});

  @override
  _HeadshotTabState createState() => _HeadshotTabState();
}

class _HeadshotTabState extends State<HeadshotTab> {
  CameraController cameraController = CameraController();

  @override
  void initState() {
    super.initState();
    task();
  }
  Future<void> task() async {
    await cameraController.initializeCameras();
    await cameraController.initializeCamera(
      setState: setState,
    );
    await cameraController.activateCamera(
      setState: setState,
      mounted: () {
        return mounted;
      },
    );
  }
  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Camera(
      cameraController: cameraController,
      onCameraNotInit: (context) {
        print("platform not init");
        return const Text("Camera no detected",
        style: TextStyle(color: Colors.white),);
      },
      onCameraNotSelect: (context) {
        print("platform not selected");
        return const SizedBox.shrink();
      },
      onCameraNotActive: (context) {
        print("platform not active");
        return const SizedBox.shrink();
      },
      onPlatformNotSupported: (context) {
        print("platform not supported");
        return const SizedBox.shrink();
      },
    );
  }

}
