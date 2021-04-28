import 'package:flutter/material.dart';

import './screens/tabs_screen.dart';

void main() {
  runApp(FivePsalms());
}

class FivePsalms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Five Psalms',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.orangeAccent,
      ),
      routes: {
        '/': (ctx) => TabsScreen(),
      },
    );
  }
}
