import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tt_36/main_view/action_history_page.dart';
import 'package:tt_36/models/affirmation.dart';
import 'package:tt_36/service/open_ai.dart';
import 'package:tt_36/styles/app_theme.dart';

class AffirmationsPage extends StatefulWidget {
  const AffirmationsPage({super.key});

  @override
  State<AffirmationsPage> createState() => _AffirmationsPageState();
}

class _AffirmationsPageState extends State<AffirmationsPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  List<Affirmation> affirmations = [];

  @override
  void initState() {
    super.initState();
    fetchAffirmations();
  }

  Future<void> fetchAffirmations() async {
    List<String> categories = [
      'love',
      'happiness',
      'health',
      'money',
      'work',
      'love',
      'happiness',
      'health',
    ];

    List<String> images = [
      'assets/images/Frame1000004490.png',
      'assets/images/Frame1000004496.png',
      'assets/images/Frame1000004493.png',
      'assets/images/Frame1000004491.png',
      'assets/images/Frame1000004494.png',
      'assets/images/Frame1000004492.png',
      'assets/images/Frame1000004489.png',
      'assets/images/Frame1000004495.png',
    ];

    List<String> forWhat = [
      'For good luck',
      'For every day',
      'For health',
      'For health',
      'For every day',
      'For money',
      'For work',
      'For work',
    ];

    List<Color> colors = [
      const Color.fromARGB(255, 252, 252, 118),
      Colors.yellowAccent,
      Colors.yellowAccent,
      Colors.white,
      Colors.black,
      Colors.red,
      Colors.black,
      Colors.white,
    ];

    for (int i = 0; i < categories.length; i++) {
      try {
        String text =
            await ApiService().getAffirmation(category: categories[i]);
        affirmations.add(
          Affirmation(
            text: text,
            imagePath: images[i],
            category: forWhat[i],
            color: colors[i],
          ),
        );
      } catch (e) {
        log('Error fetching affirmation for category ${categories[i]}: $e');
        // Optionally, provide a default affirmation or skip this category
      }
    }

    setState(() {});
  }

  Widget _buildDots() {
    List<Widget> dots = [];
    for (int i = 0; i < affirmations.length; i++) {
      dots.add(Container(
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        width: _currentPage == i ? 12.0 : 8.0,
        height: _currentPage == i ? 12.0 : 8.0,
        decoration: BoxDecoration(
          color: _currentPage == i ? AppTheme.onBackground : AppTheme.surface,
          shape: BoxShape.circle,
        ),
      ));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: dots,
    );
  }

  Widget _buildPage(int index) {
    Affirmation affirmation = affirmations[index];

    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        image: DecorationImage(
          image: AssetImage(affirmation.imagePath),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Text(
            affirmation.category,
            style: AppTheme.displaySmall.copyWith(color: affirmation.color),
          ),
          const SizedBox(height: 40),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              child: Text(
                '«${affirmation.text}»',
                style:
                    AppTheme.displayMedium.copyWith(color: affirmation.color),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: affirmations.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppTheme.surface,
                            image: const DecorationImage(
                              image: AssetImage('assets/images/Ellipse 13.png'),
                            ),
                            border: Border.all(
                              color: const Color.fromRGBO(45, 45, 51, 1),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ActionHistoryPage(),
                              ),
                            );
                          },
                          child: Container(
                            height: 48,
                            width: 48,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppTheme.surface,
                              border: Border.all(
                                color: const Color.fromRGBO(45, 45, 51, 1),
                              ),
                            ),
                            child: const Icon(
                              Icons.notifications,
                              color: AppTheme.onSurface,
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Text(
                      "Read",
                      style: AppTheme.bodyLarge.copyWith(
                        color: const Color.fromARGB(78, 252, 248, 239),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "FAVORITE\nAFFIRMATIONS",
                      style: AppTheme.displayLarge.copyWith(
                        color: AppTheme.onBackground,
                      ),
                    ),
                    const SizedBox(height: 30),
                    // PageView
                    SizedBox(
                      height: 350.0,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: affirmations.length,
                        onPageChanged: (int page) {
                          setState(() {
                            _currentPage = page;
                          });
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return _buildPage(index);
                        },
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    // Pagination Dots
                    _buildDots(),
                  ],
                ),
        ),
      ),
    );
  }
}
