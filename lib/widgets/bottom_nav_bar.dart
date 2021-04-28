import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedPageIndex;
  final List<String> pageTitles;
  final void Function(int) selectPage;

  BottomNavBar({
    required this.selectedPageIndex,
    required this.pageTitles,
    required this.selectPage,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: selectPage,
      backgroundColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.white,
      selectedItemColor: Theme.of(context).accentColor,
      currentIndex: selectedPageIndex,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book),
          label: pageTitles[0],
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book),
          label: pageTitles[1],
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book),
          label: pageTitles[2],
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book),
          label: pageTitles[3],
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book),
          label: pageTitles[4],
        ),
      ],
    );
  }
}
