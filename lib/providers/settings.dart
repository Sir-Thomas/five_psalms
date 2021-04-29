import 'package:flutter/foundation.dart';

class Settings with ChangeNotifier {
  final List<List<String>> versions = [
    ['WEB', 'web'],
    ['ASV', 'asv'],
    ['KJV', 'kjv'],
  ];
  final List<double> fontSizes = [
    17.0,
    20.0,
    23.0,
  ];
  String version = 'web';
  double fontSize = 20.0;

  void setFontSize(String? sz) {
    fontSize = double.parse(sz!);
    notifyListeners();
  }

  void setVersion(String? v) {
    version = v!;
    notifyListeners();
  }
}
