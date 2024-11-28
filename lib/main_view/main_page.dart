import 'package:flutter/material.dart';
import 'package:tt_36/styles/app_theme.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final moodGraphics = [
    GradientGraphContainer(
      gradColor1: const Color.fromARGB(51, 245, 80, 80),
      gradColor2: const Color.fromARGB(26, 245, 80, 80),
      image: 'assets/images/bad.png',
    ),
    GradientGraphContainer(
      gradColor1: const Color.fromARGB(51, 0, 88, 252),
      gradColor2: const Color.fromARGB(26, 0, 88, 252),
      image: 'assets/images/primary.png',
    ),
    GradientGraphContainer(
      gradColor1: const Color.fromARGB(51, 0, 252, 181),
      gradColor2: const Color.fromARGB(26, 0, 252, 181),
      image: 'assets/images/amazing.png',
    ),
    GradientGraphContainer(
      gradColor1: const Color.fromARGB(51, 181, 0, 252),
      gradColor2: const Color.fromARGB(26, 181, 0, 252),
      image: 'assets/images/not_bad.png',
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: moodGraphics[0]),
            Text(
              'Today',
              style: AppTheme.bodyLarge
                  .copyWith(color: const Color.fromARGB(125, 252, 248, 239)),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'CHOOSE\nWHAT\nYOU FEEL',
              style:
                  AppTheme.displayLarge.copyWith(color: AppTheme.onBackground),
            )
          ],
        ),
      )),
    );
  }
}

class GradientGraphContainer extends StatelessWidget {
  final Color gradColor1;
  final Color gradColor2;
  final String image;

  const GradientGraphContainer(
      {super.key,
      required this.gradColor1,
      required this.gradColor2,
      required this.image});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300, // Ширина контейнера
      height: 200, // Высота контейнера
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.contain),
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            gradColor1,
            gradColor2,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}
