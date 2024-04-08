import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yaqidh_game/analytics/camera.dart';
import 'package:yaqidh_game/constants.dart';
import 'package:yaqidh_game/screens/task_screen.dart';

import '../widgets/image_button.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

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
                Text("لعبة يَقِظ", style: GoogleFonts.lalezar().copyWith(fontSize: 150, color: kidDiagnosticBlue),),
                ImageButton("assets/menu/play_button.png", onTapDown: (_) => _taskScreen(context), size: 150,),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  void _taskScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => TaskScreen(levelId: 0,),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      )
    );
    Camera.recordVideo();
  }
}