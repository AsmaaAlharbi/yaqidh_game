class Logger {

  static List<LevelAnswer> answers = [];

  static logAnswer(LevelAnswer answer) {
    answers.add(answer);
  }
}

class LevelAnswer {

  final int levelId;
  final List<int> chosenOptions;

  LevelAnswer(this.levelId, this.chosenOptions);
}