import 'package:camera/camera.dart';
//import 'package:yaqidh_game/analytics/api.dart';
import 'dart:io';

class Camera {
  static bool isLoading = true;
  static bool isRecording = false;
  static late CameraController _cameraController;
  static String videoFilePath="";

  static initCamera() async {
    final cameras = await availableCameras();
    final front = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front);
    _cameraController = CameraController(front, ResolutionPreset.max);
    await _cameraController.initialize();
    isLoading = false;
  }

  static Future<void> recordVideo() async {
    if (isRecording) {
      print("IS ALREADY RECORDING (but wants to start)");
      return;
    }
    await _cameraController.prepareForVideoRecording();
    await _cameraController.startVideoRecording();
    isRecording = true;
    print("Video recording started.");
  }

  static Future<String?> stopRecordingVideo() async {
    if (!isRecording) {
      print("IS NOT RECORDING (but wants to stop)");
      return null;
    }
    try {
      final file = await _cameraController.stopVideoRecording();
      isRecording = false;
      print("FILM SAVED");
      String desktopPath = 'C:\\Users\\isooo\\OneDrive\\Desktop';
      print("Path: ${file.path}");
      String destinationPath = '$desktopPath/${file.path.split('/').last}';
      await File(file.path).copy(destinationPath);
      print("File copied to desktop successfully!");
      videoFilePath=file.path;
      return file.path; // Return the file path
    } catch (e) {
      print("Error stopping video recording: $e");
      return null;
    }
  }

  static dispose() {
    _cameraController.dispose();
  }
}
