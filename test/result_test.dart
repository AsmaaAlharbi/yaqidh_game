import 'package:flutter_test/flutter_test.dart';
import 'package:yaqidh_game/analytics/logger.dart';
import 'package:yaqidh_game/screens/finished_screen.dart';

void main() {
  group('FinishedScreen - correctAnswers calculation', () {
    setUp(() {
    });

    test('should calculate correctAnswers with mixed answers', () {
      // Mock data for Logger.answers
      Logger.answers = [
        LevelAnswer(0, [4, 0]), // Color Task: 1 correct , 1 incorrect 
        LevelAnswer(1, [0, 1, 2, 5]), // Animal Task: 3 correct , 1 incorrect 
        LevelAnswer(2, [0, 1, 4]), // Shape Task: 2 correct , 1 incorrect 
        LevelAnswer(3, [0, 1, 6, 5]), // Fruit Task: 3 correct , 1 incorrect
      ];

      // Create the FinishedScreen state instance
      final finishedScreen = FinishedScreen(studentId: 'testStudentId');
      final state = finishedScreen.createState();

      // Access correctAnswers dynamically
      final result = (state as dynamic).correctAnswers;

      expect(result, 0);
    });

    test('should calculate correctAnswers with all correct answers', () {
      // Mock data for Logger.answers
      Logger.answers = [
        LevelAnswer(0, [4]), // Color Task: 1 correct 
        LevelAnswer(1, [0, 1, 2]), // Animal Task: 3 correct 
        LevelAnswer(2, [0, 4]), // Shape Task: 2 correct 
        LevelAnswer(3, [0, 1, 6]), // Fruit Task: 3 correct 
      ];

      // Create the FinishedScreen state instance
      final finishedScreen = FinishedScreen(studentId: 'testStudentId');
      final state = finishedScreen.createState();

      // Access correctAnswers dynamically
      final result = (state as dynamic).correctAnswers;
      expect(result, 9);
    });
  });
}
