import 'package:flutter/material.dart';
import 'package:yaqidh_game/widgets/timer.dart';

class ContentScreen extends StatelessWidget {

  final Widget child;
  final VoidCallback timeElapsed;
  final int seconds;

  const ContentScreen({super.key, required this.child, required this.timeElapsed, required this.seconds});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4EC7FD),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/menu/background.png"),
            fit: BoxFit.fitWidth,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                TimerWidget(timeElapsed: timeElapsed, seconds: seconds,),
                const SizedBox(height: 25,),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: child,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
