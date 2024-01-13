import 'package:flutter/material.dart';
import 'package:meals/Models/meal.dart';
import 'package:meals/Screens/categories.dart';
import 'package:meals/Screens/meals.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _setPageIndex = 0;
  final List<Meal> _favourites = [];

  void _toggleFavouriteMealState(Meal meal) {
    final isExisting = _favourites.contains(meal);
    if (isExisting) {
      setState(() {
        _favourites.remove(meal);
      });

    } else {
      setState(() {
        _favourites.add(meal);
      });
    }
  }

  void _setPage(int index) {
    setState(() {
      _setPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget active = Categories(setFavouriteState: _toggleFavouriteMealState,label:'Categories');
    if (_setPageIndex == 1) {
      active = Meals(
        title: 'Favourites',
        meals: _favourites,
        setFavouriteState: _toggleFavouriteMealState,
      );
    }
    return Scaffold(
      body: active,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          _setPage(index);
        },
        currentIndex: _setPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favourites',
          ),
        ],
      ),
    );
  }
}
