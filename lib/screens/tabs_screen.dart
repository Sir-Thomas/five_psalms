import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './psalm_screen.dart';
import '../widgets/bottom_nav_bar.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<int> _psalms = [];
  List<String> _pageTitles = [];
  List<Widget> _pages = [];
  int _selectedPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _psalms = _getPsalmsList();
    _pages = _getPages();
    _pageTitles = _getPageTitles();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  List<int> _getPsalmsList() {
    return [
      int.parse(DateFormat.d().format(DateTime.now())),
      int.parse(DateFormat.d().format(DateTime.now())) + 30,
      int.parse(DateFormat.d().format(DateTime.now())) + 60,
      int.parse(DateFormat.d().format(DateTime.now())) + 90,
      int.parse(DateFormat.d().format(DateTime.now())) + 120,
    ];
  }

  List<String> _getPageTitles() {
    return [
      'Psalm ${_psalms[0]}',
      'Psalm ${_psalms[1]}',
      'Psalm ${_psalms[2]}',
      'Psalm ${_psalms[3]}',
      'Psalm ${_psalms[4]}',
    ];
  }

  List<Widget> _getPages() {
    return [
      PsalmScreen(psalmNumber: _psalms[0], key: Key(_psalms[0].toString())),
      PsalmScreen(psalmNumber: _psalms[1], key: Key(_psalms[1].toString())),
      PsalmScreen(psalmNumber: _psalms[2], key: Key(_psalms[2].toString())),
      PsalmScreen(psalmNumber: _psalms[3], key: Key(_psalms[3].toString())),
      PsalmScreen(psalmNumber: _psalms[4], key: Key(_psalms[4].toString())),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageTitles[_selectedPageIndex]),
      ),
      body: _pages[_selectedPageIndex],
      bottomNavigationBar: BottomNavBar(
        pageTitles: _pageTitles,
        selectedPageIndex: _selectedPageIndex,
        selectPage: _selectPage,
      ),
    );
  }
}
