import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yaqidh_game/screens/task_screen.dart';
import 'package:yaqidh_game/widgets/content_screen.dart';
import 'package:video_player/video_player.dart';

class PauseScreen extends StatefulWidget {

  final int nextLevelId;

  const PauseScreen({super.key, required this.nextLevelId});

  @override
  State<PauseScreen> createState() => _PauseScreenState();
}

class _PauseScreenState extends State<PauseScreen> {

  VideoPlayerController? _controller;
  late Future _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/images/hour_glass.mp4")
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((value) => _controller!.play());
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ContentScreen(
      timeElapsed: () => _nextLevel(context),
      seconds: 10,
      child: Column(
        children: [
          const Text("فلننتظر قليلًا", style: TextStyle(fontSize: 60),),
          Center(
            child: SizedBox(
              height: 400,
              child: _controller != null && _controller!.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller!.value.aspectRatio,
                      child:VideoPlayer(_controller!),
                    )
                  : const CircularProgressIndicator()
            ),
          ),
        ],
      ),
    );
  }

  void _nextLevel(BuildContext context) {

    Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => TaskScreen(levelId: widget.nextLevelId),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        )
    );
  }
}
