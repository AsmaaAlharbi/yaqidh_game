import 'package:flutter/material.dart';
import 'package:yaqidh_game/analytics/camera.dart';
import 'package:yaqidh_game/analytics/logger.dart';
import 'package:yaqidh_game/helper/level.dart';
import 'package:yaqidh_game/screens/menu_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import '../constants.dart';

class FinishedScreen extends StatefulWidget {
  final String studentId;

  const FinishedScreen({Key? key, required this.studentId}) : super(key: key);

  @override
  State<FinishedScreen> createState() => _FinishedScreenState();
}

class _FinishedScreenState extends State<FinishedScreen> {
  bool dataTransmitted = false;
  String? videoFilePath;

  int get correctAnswers {
    List<bool> answerCorrectness = [];
    for (int i = 0; i < Logger.answers.length; i++) {
      LevelAnswer a = Logger.answers[i];
      answerCorrectness.addAll(a.chosenOptions.map((e) => levels[i].options[e].isCorrect));
    }
    int correctAnswers = 0;
    for (int i = 0; i < answerCorrectness.length; i++) {
      if (answerCorrectness[i]) {
        correctAnswers++;
      } else {
        correctAnswers--;
      }
    }
    if (correctAnswers < 0) {
      correctAnswers = 0;
    }
    return correctAnswers;
  }

  @override
  void initState() {
    _stopRecordingAndSaveData();
    super.initState();
  }

  Future<void> _stopRecordingAndSaveData() async {
    videoFilePath = await Camera.stopRecordingVideo();
    //if (videoFilePath != null) {
      await _uploadVideoAndSaveData(widget.studentId);
    //}
    setState(() {
      dataTransmitted = true;
    });
  }

  Future<void> _uploadVideoAndSaveData(String studentId) async {
    try {
      // Upload video to Firebase Storage
      /*File videoFile = File(videoFilePath!);
      String fileName = 'videos/${DateTime.now().millisecondsSinceEpoch}.mp4';
      Reference storageRef = FirebaseStorage.instance.ref().child(fileName);
      UploadTask uploadTask = storageRef.putFile(videoFile);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      String videoUrl = await taskSnapshot.ref.getDownloadURL();*/

      // Save video URL and correct answers to Firestore
      await FirebaseFirestore.instance.collection('students').doc(studentId).update({
        //'videoUrl': videoUrl,
        'correctAnswers': correctAnswers,
        'isTested': true,
      });

      print('Data saved successfully.');
    } catch (e) {
      print('Error saving data: $e');
      _showErrorDialog('Error saving data. Please try again later.');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/menu/background.png"),
            fit: BoxFit.fitWidth,
          ),
        ),
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/menu/backgroundAnimals.png"),
              fit: BoxFit.fitWidth,
              alignment: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(30))
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 75,
                          width: 75,
                          child: correctAnswers >= 3 ? Image.asset("assets/images/star.png") : Container(),
                        ),
                        SizedBox(
                          height: 75,
                          width: 75,
                          child: correctAnswers >= 6 ? Image.asset("assets/images/star.png") : Container(),
                        ),
                        SizedBox(
                          height: 75,
                          width: 75,
                          child: correctAnswers >= 9 ? Image.asset("assets/images/star.png") : Container(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15,),
                    const Text("الدرجة الكلية", style: TextStyle(fontSize: 30, color: kidDiagnosticBlue,),),
                    Text("9 / $correctAnswers", style: const TextStyle(fontSize: 40, color: kidDiagnosticBlue,),),
                    const SizedBox(height: 15,),
                    GestureDetector(
                      onTapDown: (_) => { _backToMenu(context) },
                      child: Container(
                        decoration: BoxDecoration(
                          color: dataTransmitted ? kidDiagnosticBlue : kidDiagnosticBlueDisabled,
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8),child: Text("Menu", style: TextStyle(fontSize: 25, color: Colors.white),),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _getAllAnswers() {
    return Logger.answers.map((levelAnswer) =>
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
              children: [
                Text(levels[levelAnswer.levelId].task, style: const TextStyle(fontSize: 30, color: kidDiagnosticBlue),),
                const SizedBox(width: 15,),
                ..._getChosenItemsAsImages(levelAnswer)
              ]
          ),
        ),
    ).toList();
  }

List<Widget> _getChosenItemsAsImages(LevelAnswer levelAnswer) {
    return levelAnswer.chosenOptions.map((option) =>
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: SizedBox(
            height: 75,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0x99FFFFFF),
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Image.asset(levels[levelAnswer.levelId].options[option].path),
              ),
            ),
          ),
        ),
    ).toList();
  }

  void _backToMenu(BuildContext context) {
    if (!dataTransmitted) {
      return;
    }
    Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => const MenuScreen(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        )
    );
  }
}