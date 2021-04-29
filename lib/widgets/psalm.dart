import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../providers/settings.dart';

class PsalmData {
  final Map<String, dynamic>? psalmJson;

  PsalmData(this.psalmJson);

  factory PsalmData.fromJson(Map<String, dynamic> json) {
    return PsalmData(json['chapter']);
  }

  Widget formatVerse(BuildContext context, int verse, String text) {
    final settings = Provider.of<Settings>(context);
    String output = ' ';
    output += text.trim();
    output += '\n';
    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(
            child: Transform.translate(
              offset: Offset(0, -4),
              child: Text(
                verse.toString(),
                textScaleFactor: 0.7,
                style: TextStyle(fontSize: settings.fontSize),
              ),
            ),
          ),
          TextSpan(
            text: output,
            style: TextStyle(
              color: Colors.black,
              fontSize: settings.fontSize,
            ),
          ),
        ],
      ),
    );
  }

  Widget showPsalm(BuildContext context) {
    List<Widget> psalm = [];
    psalmJson!.forEach((key, value) {
      psalm.add(formatVerse(context, value['verse_nr'], value['verse']));
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: psalm,
    );
  }
}

class Psalm extends StatefulWidget {
  final int? psalmNumber;
  final String version;

  Psalm({
    Key? key,
    required this.psalmNumber,
    required this.version,
  }) : super(key: key);

  @override
  _PsalmState createState() => _PsalmState();
}

class _PsalmState extends State<Psalm> {
  Future<PsalmData>? futurePsalm;

  String _removeExtraSymbols(String s) {
    return s.substring(1, s.length - 2);
  }

  Future<PsalmData> _fetchPsalmData(int? psalm) async {
    final response = await http.get(Uri.https(
        'getbible.net', 'json', {'p': 'ps$psalm', 'v': widget.version}));

    var _validResponse = response.statusCode == 200;

    if (_validResponse) {
      return PsalmData.fromJson(jsonDecode(_removeExtraSymbols(response.body)));
    } else {
      throw Exception('Failed to load psalm');
    }
  }

  @override
  void initState() {
    super.initState();
    futurePsalm = _fetchPsalmData(widget.psalmNumber);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PsalmData>(
      future: futurePsalm,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!.showPsalm(context);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
