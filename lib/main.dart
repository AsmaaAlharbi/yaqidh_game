import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yaqidh_game/analytics/camera.dart';
import 'package:yaqidh_game/screens/menu_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
  Camera.initCamera();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textTheme: GoogleFonts.lalezarTextTheme(),
        useMaterial3: true,
      ),
      home: const MenuScreen(),
    );
  }
}
