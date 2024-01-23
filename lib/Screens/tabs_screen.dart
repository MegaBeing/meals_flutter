import 'package:flutter/material.dart';
import 'package:meals/Data/dummy_data.dart';
import 'package:meals/Models/meal.dart';
import 'package:meals/Screens/categories.dart';
import 'package:meals/Screens/filters.dart';
import 'package:meals/Screens/meals.dart';
import 'package:meals/Widgets/main_drawer.dart';
const kInitialFilters = {
  Filters.glutenFree: false,
  Filters.lactosFree: false,
  Filters.vegetarian: false,
  Filters.vegan: false,
};
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
  Map<Filters,bool> _selectedFilters= kInitialFilters;
  void _showMsg(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _toggleFavouriteMealState(Meal meal) {
    final isExisting = _favourites.contains(meal);
    if (isExisting) {
      setState(() {
        _favourites.remove(meal);
        _showMsg("Meal removed from Favourites");
      });
    } else {
      setState(() {
        _favourites.add(meal);
        _showMsg("Meal added to Favourites");
      });
    }
  }

  void _setPage(int index) {
    setState(() {
      _setPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filters,bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(currentFilters: _selectedFilters,),
        ),
      );
      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((meal){
      if(!meal.isGlutenFree && _selectedFilters[Filters.glutenFree]!) {
        return false;
      }
      if(!meal.isLactoseFree&& _selectedFilters[Filters.lactosFree]!) {
        return false;
      }
      if(!meal.isVegan && _selectedFilters[Filters.vegan]!) {
        return false;
      }
      if(!meal.isVegetarian&& _selectedFilters[Filters.vegetarian]!) {
        return false;
      }
      return true;
    }).toList();
    String label = "Categories";
    Widget active = Categories(setFavouriteState: _toggleFavouriteMealState,filteredList: availableMeals,);
    if (_setPageIndex == 1) {
      label = "Favourites";
      active = Meals(
        meals: _favourites,
        setFavouriteState: _toggleFavouriteMealState,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(label),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
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
