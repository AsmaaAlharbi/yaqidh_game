import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yaqidh_game/constants.dart';

class TimerWidget extends StatefulWidget {

  static const double _width = 500;
  static const double _height = 60;
  final VoidCallback timeElapsed;
  final int seconds;

  const TimerWidget({super.key, required this.timeElapsed, required this.seconds});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {

  double get percentage {
    if (timeElapsed >= widget.seconds) {
      return 1;
    } else if (timeElapsed <= 0) {
      return 0;
    } else {
      return 1 - (timeElapsed / widget.seconds);
    }
  }
  double timeElapsed = 1;

  late Timer timer;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        timeElapsed += 0.01;
      });
      if (timeElapsed >= widget.seconds) {
        timer.cancel();
        widget.timeElapsed();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: percentage > 0.25 ? kidDiagnosticBlue : kidDiagnosticRed,
          width: 6,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(30)),
      ),
      height: TimerWidget._height,
      width: TimerWidget._width,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: percentage > 0.25 ? kidDiagnosticBlue : kidDiagnosticRed,
              borderRadius: const BorderRadius.all(Radius.circular(30)),
            ),
            height: TimerWidget._height,
            width: TimerWidget._width * percentage * 0.975,
          ),
        ],
      ),
    );
  }
}
