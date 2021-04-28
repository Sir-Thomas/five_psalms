import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/settings.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings';

  Widget _buildVersionSelect(Settings settings) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Version',
          style: TextStyle(fontSize: 20),
        ),
        DropdownButton(
          value: settings.version,
          onChanged: (newValue) => settings.setVersion(newValue.toString()),
          items: settings.versions.map<DropdownMenuItem<String>>((value) {
            return DropdownMenuItem<String>(
              child: Text(value),
              value: value,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildFontSizeSelect(Settings settings) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Font Size',
          style: TextStyle(fontSize: 20),
        ),
        DropdownButton(
          value: settings.fontSize,
          onChanged: (newValue) => settings.setFontSize(newValue.toString()),
          items: settings.fontSizes.map<DropdownMenuItem<double>>((value) {
            return DropdownMenuItem<double>(
              child: Text(value.toString()),
              value: value,
            );
          }).toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settings>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildVersionSelect(settings),
            _buildFontSizeSelect(settings),
          ],
        ),
      ),
    );
  }
}
