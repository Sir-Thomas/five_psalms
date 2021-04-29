import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/psalm.dart';
import '../providers/settings.dart';

class PsalmScreen extends StatelessWidget {
  final int psalmNumber;

  PsalmScreen({
    required this.psalmNumber,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settings>(context);
    return Scrollbar(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(15),
          child: Psalm(
            psalmNumber: psalmNumber,
            version: settings.version,
          ),
        ),
      ),
    );
  }
}
