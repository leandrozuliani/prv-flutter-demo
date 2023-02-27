import 'package:flutter/material.dart';

class Disclaimers with ChangeNotifier {
  Map<String, String> disclaimer;

  Disclaimers({required this.disclaimer});

  void add(entries) {
    disclaimer.addAll(entries);
    notifyListeners();
  }
}
