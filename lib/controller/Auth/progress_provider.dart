import 'package:flutter/material.dart';

class SignUpProgressProvider with ChangeNotifier {
  double _progress = 0.0;

  double get progress => _progress;

  void increaseProgress(double value) {
    _progress += value;
    notifyListeners();
  }

  void resetProgress() {
    _progress = 0.0;
    notifyListeners();
  }
}
