import 'package:flutter/material.dart';

import './categories_screen.dart';
import './favorites_screen.dart';
import '../widgets/main_drawer.dart';

import '../models/meal.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoritedMeals;

  TabsScreen(this.favoritedMeals);

  @override
  _TabsScreenState createState() => _TabsScreenState();
  static const String routeName = '/';
}

class _TabsScreenState extends State<TabsScreen> {
  late List<Map<String, Object>> _pages;

  int _selectedPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pages = [
      {'page': CategoriesScreen(), 'title': 'Categories'},
      {'page': FavoritesScreen(widget.favoritedMeals), 'title': 'Favorites'},
    ];
  }

  void _selectPage(index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  // final List<Widget> myTabs = [
  //   Tab(
  //     icon: Icon(Icons.category),
  //     text: 'Categories',
  //   ),
  //   Tab(
  //     icon: Icon(Icons.star),
  //     text: 'Favorites',
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title'] as String),
        // bottom: TabBar(
        //   tabs: myTabs,
        //   indicatorWeight: 3,
        // ),
      ),
      drawer: MainDrawer(),
      body: _pages.elementAt(_selectedPageIndex)['page'] as Widget,
      // _pages[_selectedPageIndex]['page'] as Widget,
      // TabBarView(
      //   children: <Widget>[
      //     CategoriesScreen(),
      //     FavoritesScreen(),
      //   ],
      // ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        // type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            // backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(
              Icons.category,
            ),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.star,
            ),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
