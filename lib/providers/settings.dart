import 'package:flutter/foundation.dart';

class Settings with ChangeNotifier {
  final List<String> versions = [
    'web',
    'asv',
    'kjv',
    'ylt',
  ];
  final List<double> fontSizes = [18, 20, 22];
  String version = 'web';
  double fontSize = 20;

  void setFontSize(String? sz) {
    fontSize = double.parse(sz!);
    notifyListeners();
  }

  void setVersion(String? v) {
    version = v!;
    notifyListeners();
  }
}
