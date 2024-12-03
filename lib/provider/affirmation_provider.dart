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
    List<String> images = [
      'assets/images/Frame1000004490.png',
      'assets/images/Frame1000004496.png',
      'assets/images/Frame1000004493.png',
      'assets/images/Frame1000004491.png',
      'assets/images/Frame1000004494.png',
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

    for (int i = 0; i < 5; i++) {
      try {
        final data = await ApiService().getAffirmation();
        _affirmations.add(
          Affirmation(
            text: data['text'],
            imagePath: images[i],
            category: data['category'],
            color: colors[i],
          ),
        );
      } catch (e) {
        log('Error fetching affirmation for category');
      }
    }

    notifyListeners();
  }

  void setCurrentPage(int page) {
    _currentPage = page;
    notifyListeners();
  }
}
