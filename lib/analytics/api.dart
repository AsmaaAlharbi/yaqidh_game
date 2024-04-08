import 'package:yaqidh_game/analytics/logger.dart';
import 'package:yaqidh_game/helper/level.dart';

class Api {

  static Future<void> transferData(String videoFilePath) async {
    // TODO transfer data
    // you get the answers from Logger.answers
    Logger.answers[0].chosenOptions; // Chosen options of level 1 (with id = 0)
    // you get the levels by doing this:
    levels[0].options[3].isCorrect; // is the 4th option of level 1 correct?
  }
}