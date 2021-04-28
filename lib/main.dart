import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/settings.dart';
import './screens/tabs_screen.dart';
import './screens/settings_screen.dart';

void main() {
  runApp(FivePsalms());
}

class FivePsalms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Settings()),
      ],
      child: MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settings>(context);
    return MaterialApp(
      title: 'Five Psalms',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.orangeAccent,
        textTheme: TextTheme(
          bodyText2: TextStyle(fontSize: settings.fontSize),
        ),
      ),
      routes: {
        '/': (ctx) => TabsScreen(),
        SettingsScreen.routeName: (ctx) => SettingsScreen(),
      },
    );
  }
}
