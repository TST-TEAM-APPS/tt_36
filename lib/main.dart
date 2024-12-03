import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tt_36/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:tt_36/models/mood_entry.dart';
import 'package:tt_36/onboarding_view/onboarding_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(MoodEntryAdapter());
  await Hive.openBox('settings');
  await Hive.openBox<MoodEntry>('moodBox');

  // Check if onboarding is completed
  var settingsBox = Hive.box('settings');
  bool isOnboardingCompleted =
      settingsBox.get('isOnboardingCompleted', defaultValue: false);

  runApp(MainApp(isOnboardingCompleted: isOnboardingCompleted));
}

class MainApp extends StatelessWidget {
  final bool isOnboardingCompleted;

  const MainApp({super.key, required this.isOnboardingCompleted});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Onest',
      ),
      debugShowCheckedModeBanner: false,
      home: isOnboardingCompleted
          ? const CustomNavigationBar()
          : const OnboardingScreen(),
    );
  }
}
