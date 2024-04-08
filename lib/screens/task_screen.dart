import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:yaqidh_game/screens/finished_screen.dart';
import 'package:yaqidh_game/screens/pause_screen.dart';
import 'package:yaqidh_game/widgets/content_screen.dart';
import 'package:yaqidh_game/widgets/image_button.dart';

import '../analytics/logger.dart';
import '../helper/level.dart';

class TaskScreen extends StatefulWidget {

  final int levelId;

  late final int wantedItem;

  Level get level => levels[levelId];
  int get optionAmount => level.options.length;
  int get itemsPerRow => (optionAmount / 2).ceil();

  TaskScreen({super.key, required this.levelId}) {
    wantedItem = Random().nextInt(optionAmount);
  }

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<int> selectedItems = [];

  @override
  void initState() {
    _playSound();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ContentScreen(
      timeElapsed: () => _timeElapsed(context),
      seconds: 25,
      child: Stack(
        children: [
          ImageButton("assets/menu/sound_button.png", onTapDown: (_) => _playSound(),),
          Column(
            children: [
              Text(widget.level.task, style: const TextStyle(fontSize: 60),),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: widget.itemsPerRow,
                    childAspectRatio: _calcChildAspectRatio(context),
                  ),
                  itemCount: widget.optionAmount,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTapDown: (_) => _tapOnFruit(context, index),
                      child: Container(
                        margin: const EdgeInsets.all(17),
                        decoration: BoxDecoration(
                          color: selectedItems.contains(index) ? const Color(0xFF83EF83) : const Color(0xFFEEEEEE),
                          borderRadius: const BorderRadius.all(Radius.circular(30))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(17),
                          child: Center(
                            child: Image.asset(widget.level.options[index].path),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _playSound() {
    AudioPlayer player = AudioPlayer();
    player.play(AssetSource(widget.level.audio));
  }

  void _tapOnFruit(BuildContext context, int index) {

    setState(() {
      if (selectedItems.contains(index)) {
        selectedItems.remove(index);
      } else {
        selectedItems.add(index);
      }
    });
  }

  void _timeElapsed(BuildContext context) {
    _logAnswers();
    _changeScreen(context);
  }

  void _logAnswers() {
    Logger.logAnswer(LevelAnswer(widget.levelId, selectedItems));
  }

  void _changeScreen(BuildContext context) {

    Widget newScreen;
    if (widget.levelId + 1 == levels.length) {
      newScreen = const FinishedScreen();
    } else {
      newScreen = PauseScreen(nextLevelId: widget.levelId + 1);
    }

    Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => newScreen,
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        )
    );
  }

  double _calcChildAspectRatio(BuildContext context) {
    return (MediaQuery.of(context).size.width / widget.itemsPerRow) / ((MediaQuery.of(context).size.height - 250) / (widget.optionAmount/widget.itemsPerRow).ceil());
  }
}
