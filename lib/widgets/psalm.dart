import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PsalmData {
  final Map<String, dynamic>? psalmJson;

  PsalmData(this.psalmJson);

  factory PsalmData.fromJson(Map<String, dynamic> json) {
    return PsalmData(json['chapter']);
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
  final int? psalmNumber;
  Psalm({Key? key, required this.psalmNumber}) : super(key: key);

  @override
  _PsalmState createState() => _PsalmState();
}

class _PsalmState extends State<Psalm> {
  Future<PsalmData>? futurePsalm;

  String _removeExtraSymbols(String s) {
    return s.substring(1, s.length - 2);
  }

  Future<PsalmData> _fetchPsalmData(int? psalm) async {
    final response = await http
        .get(Uri.https('getbible.net', 'json', {'p': 'ps$psalm', 'v': 'web'}));

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
          return Text(snapshot.data!.showPsalm());
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
