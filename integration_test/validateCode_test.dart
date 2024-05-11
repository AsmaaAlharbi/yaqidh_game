import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaqidh_game/screens/task_screen.dart';
import 'package:integration_test/integration_test.dart';
import 'package:yaqidh_game/widgets/image_button.dart';
import 'package:yaqidh_game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets(
      'verify error dialog for valid but already tested code',
      (tester) async {
        print('Starting test for valid but already tested code...');
        app.main();
        await tester.pumpAndSettle();
        expect(find.byType(TextField), findsWidgets);

        await tester.enterText(find.byType(TextField).first, '262639');
        await Future.delayed(const Duration(seconds: 3));
        await tester.pumpAndSettle();
        await tester.tap(find.byType(ImageButton).first);
        await Future.delayed(const Duration(seconds: 3));
        await tester.pumpAndSettle();

        String studentName = 'مها احمد'; 
        print('Checking for error dialog with student name...');
        expect(find.textContaining(' ($studentName)  لقد تم اختبار الطالب'),
            findsOneWidget);
        await Future.delayed(const Duration(seconds: 5));
        print('Test for valid but already tested code passed.');
      },
    );

    testWidgets(
      'verify error dialog for invalid code',
      (tester) async {
        print('Starting test for invalid code...');
        app.main();
        await tester.pumpAndSettle();

        expect(find.byType(TextField), findsWidgets);

        await tester.enterText(find.byType(TextField).first, '123456');
        await Future.delayed(const Duration(seconds: 3));
        await tester.pumpAndSettle();
        await tester.tap(find.byType(ImageButton).first);
        await Future.delayed(const Duration(seconds: 3));
        await tester.pumpAndSettle();

        print('Checking for error dialog with invalid code message...');
        expect(find.text('الكود غير صالح '), findsOneWidget);
        await Future.delayed(const Duration(seconds: 5));
        print('Test for invalid code passed.');
      },
    );

    testWidgets(
      'verify main screen with valid and not tested code',
      (tester) async {
        print('Starting test for valid code and not tested...');
        app.main();
        await tester.pumpAndSettle();

        expect(find.byType(TextField), findsWidgets);

        await tester.enterText(find.byType(TextField).first, '662642');
        await Future.delayed(const Duration(seconds: 3));
        await tester.pumpAndSettle();
        await tester.tap(find.byType(ImageButton).first);
        await Future.delayed(const Duration(seconds: 3));
        await tester.pumpAndSettle();

        print('Checking for TaskScreen...');
        expect(
          find.byWidgetPredicate(
            (Widget widget) =>
                widget is TaskScreen &&
                widget.levelId == 0 &&
                widget.studentId == '26665324',
          ),
          findsOneWidget,
        );
        await Future.delayed(const Duration(seconds: 3));
        print('Test for valid code and not tested passed.');
      },
    );
  });
}
