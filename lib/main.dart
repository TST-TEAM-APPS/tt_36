import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tt_36/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:tt_36/models/mood_entry.dart';
import 'package:tt_36/mood_graphic_view/mood_graphic_page.dart';
import 'package:tt_36/onboarding_view/onboarding_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Инициализация Hive
  await Hive.initFlutter();
  Hive.registerAdapter(MoodEntryAdapter());
  await Hive.openBox('settings');
  await Hive.openBox<MoodEntry>('moodBox');

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Onest',
      ),
      debugShowCheckedModeBanner: false,
      home: const OnboardingScreen(),
    );
  }
}
