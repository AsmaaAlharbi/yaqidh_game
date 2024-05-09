import 'pair.dart';

class Level {

  final String task;
  final String audio;
  final List<Option> options;

  const Level(this.task, this.audio, this.options);
}

const List<Level> levels = [
  Level("اختر اللون المطلوب", "sound/color.mp3", [
    Option("assets/images/yellow_pen.png", false),
    Option("assets/images/purple_pen.png", false),
    Option("assets/images/white_pen.png", false),
    Option("assets/images/orange_pen.png", false),
    Option("assets/images/red_pen.png", true),
    Option("assets/images/green_pen.png", false),
    Option("assets/images/blue_pen.png", false),
    Option("assets/images/black_pen.png", false),
  ]),
  Level("اختر الحيوانات المطلوبه", "sound/animals.mp3", [
    Option("assets/images/cat.png", true),
    Option("assets/images/elephant.png", true),
    Option("assets/images/lion.png", true),
    Option("assets/images/monkey.png", false),
    Option("assets/images/snake.png", false),
    Option("assets/images/turtle.png", false),
  ]),
  Level("اختر الشكل المطلوب", "sound/shape.mp3", [
    Option("assets/images/heart.png", true),
    Option("assets/images/octagon.png", false),
    Option("assets/images/oval.png", false),
    Option("assets/images/square.png", false),
    Option("assets/images/star.png", true),
    Option("assets/images/triangle.png", false),
  ]),
  Level("اختر الفواكه المطلوبه", "sound/fruits.mp3", [
    Option("assets/images/apple.png", true),
    Option("assets/images/banana.png", true),
    Option("assets/images/cherry.png", false),
    Option("assets/images/melon.png", false),
    Option("assets/images/orange.png", false),
    Option("assets/images/pineapple.png", false),
    Option("assets/images/strawberry.png", true),
  ]),
];