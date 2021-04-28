import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<PsalmData> fetchPsalmData(int? psalm) async {
  final response = await http
      .get(Uri.https('getbible.net', 'json', {'p': 'ps$psalm', 'v': 'web'}));

  if (response.statusCode == 200) {
    return PsalmData.fromJson(
        jsonDecode(response.body.substring(1, response.body.length - 2)));
  } else {
    throw Exception('Failed to load psalm');
  }
}

class PsalmData {
  final Map<String, dynamic>? psalmJson;

  PsalmData({required this.psalmJson});

  factory PsalmData.fromJson(Map<String, dynamic> json) {
    return PsalmData(psalmJson: json['chapter']);
  }

  String showPsalm() {
    String psalm = '';
    psalmJson!.forEach((key, value) {
      psalm += value['verse'].trim();
      psalm += '\n';
    });
    return psalm;
  }
}

class Psalm extends StatefulWidget {
  final int? psalm;
  Psalm({Key? key, this.psalm}) : super(key: key);

  @override
  _PsalmState createState() => _PsalmState();
}

class _PsalmState extends State<Psalm> {
  Future<PsalmData>? futurePsalm;

  @override
  void initState() {
    super.initState();
    futurePsalm = fetchPsalmData(widget.psalm);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PsalmData>(
      future: futurePsalm,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.showPsalm());
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
