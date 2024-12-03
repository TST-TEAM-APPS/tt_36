import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:tt_36/models/affirmation.dart';
import 'package:tt_36/service/open_ai.dart';

class AffirmationProvider with ChangeNotifier {
  final List<Affirmation> _affirmations = [];
  int _currentPage = 0;

  List<Affirmation> get affirmations => _affirmations;
  int get currentPage => _currentPage;

  AffirmationProvider() {
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
        _affirmations.add(
          Affirmation(
            text: text,
            imagePath: images[i],
            category: forWhat[i],
            color: colors[i],
          ),
        );
      } catch (e) {
        log('Error fetching affirmation for category ${categories[i]}: $e');
      }
    }

    notifyListeners();
  }

  void setCurrentPage(int page) {
    _currentPage = page;
    notifyListeners();
  }
}
