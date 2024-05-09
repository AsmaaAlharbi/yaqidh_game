import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yaqidh_game/analytics/camera.dart';
import 'package:yaqidh_game/constants.dart';
import 'package:yaqidh_game/screens/task_screen.dart';
import 'package:yaqidh_game/widgets/image_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final TextEditingController _codeController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _validateCode() async {
    String enteredCode = _codeController.text.trim();

    try {
      QuerySnapshot querySnapshot = await _firestore.collection('students').get();
      bool codeFound = false;

      for (var doc in querySnapshot.docs) {
        String storedCode = doc['code'].toString().trim();
        bool isTested = doc['isTested'];
        String stuName = doc['fullName'].toString();

        print('Checking student ID: ${doc.id}');
        print('Entered Code: $enteredCode');
        print('Stored Code: $storedCode');
        print('isTested: $isTested');

        if (enteredCode == storedCode) {
          codeFound = true;
          if (!isTested) {
            print('Code is valid and student is not tested. Starting game...');
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) => TaskScreen(
                  levelId: 0, 
                  studentId: doc.id, // Pass studentId
                ),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ),
            );
            Camera.recordVideo();
            break;
          } else {
            _showErrorDialog(' ($stuName)  لقد تم اختبار الطالب' );
          }
        }
      }

      if (!codeFound) {
        _showErrorDialog('الكود غير صالح ');
      }
    } catch (e) {
      _showErrorDialog('Error fetching student data. Please try again later.');
      print('Error fetching student data: $e');
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "لعبة يَقِظ",
                  style: GoogleFonts.lalezar().copyWith(fontSize: 120, color: kidDiagnosticBlue),
                ),
                SizedBox(height: 20),
                Container(
                  width: 300,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: kidDiagnosticBlue, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _codeController,
                    decoration: InputDecoration(
                      hintText: 'أدخل رمز اللعبه',
                      border: InputBorder.none,
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(height: 20),
                ImageButton(
                  "assets/menu/play_button.png",
                  onTapDown: (_) => _validateCode(),
                  size: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}