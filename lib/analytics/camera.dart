import 'package:camera/camera.dart';
import 'package:yaqidh_game/analytics/api.dart';
import 'dart:io';

class Camera {
  static bool isLoading = true;
  static bool isRecording = false;
  static late CameraController _cameraController;

  static initCamera() async {
    final cameras = await availableCameras();
    final front = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front);
    _cameraController = CameraController(front, ResolutionPreset.max);
    await _cameraController.initialize();
    isLoading;
  }

  static recordVideo() async {
    if (isRecording) {
      print("IS ALREADY RECORDING (but wants to start)");
      return;
    }
    await _cameraController.prepareForVideoRecording();
    await _cameraController.startVideoRecording();
    isRecording = true;
  }

  static stopRecordingVideo() async {
    if (!isRecording) {
      print("IS NOT RECORDING (but wants to stop)");
      return;
    }
    /*final file = await _cameraController.stopVideoRecording();
    isRecording = false;
    print("FILM SAVED");
    print("Path: ${file.path}");
    await Api.transferData(file.path);*/

    final file = await _cameraController.stopVideoRecording();
    isRecording = false;
    print("FILM SAVED");
    String desktopPath = 'C:\\Users\\isooo\\OneDrive\\Desktop'; 
    print("Path: ${file.path}");
    String destinationPath = '$desktopPath/${file.path.split('/').last}';
    await File(file.path).copy(destinationPath);
    print("File copied to desktop successfully!");
  }

  static dispose() {
    _cameraController.dispose();
  }
}
