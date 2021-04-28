import 'package:flutter/material.dart';

import '../widgets/psalm.dart';

class PsalmScreen extends StatelessWidget {
  final int psalmNumber;

  PsalmScreen({required this.psalmNumber, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(15),
        child: Psalm(
          psalmNumber: psalmNumber,
        ),
      ),
    );
  }
}
