import 'package:flutter/material.dart';
import 'package:meals/Data/dummy_data.dart';
import 'package:meals/Models/meal.dart';
import 'package:meals/Screens/categories.dart';
import 'package:meals/Screens/filters.dart';
import 'package:meals/Screens/meals.dart';
import 'package:meals/Widgets/main_drawer.dart';
import 'package:meals/Providers/favourite_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const kInitialFilters = {
  Filters.glutenFree: false,
  Filters.lactosFree: false,
  Filters.vegetarian: false,
  Filters.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _setPageIndex = 0;
  Map<Filters, bool> _selectedFilters = kInitialFilters;

  void _setPage(int index) {
    setState(() {
      _setPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filters, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(
            currentFilters: _selectedFilters,
          ),
        ),
      );
      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((meal) {
      if (!meal.isGlutenFree && _selectedFilters[Filters.glutenFree]!) {
        return false;
      }
      if (!meal.isLactoseFree && _selectedFilters[Filters.lactosFree]!) {
        return false;
      }
      if (!meal.isVegan && _selectedFilters[Filters.vegan]!) {
        return false;
      }
      if (!meal.isVegetarian && _selectedFilters[Filters.vegetarian]!) {
        return false;
      }
      return true;
    }).toList();
    String label = "Categories";
    Widget active = Categories(
      filteredList: availableMeals,
    );
    if (_setPageIndex == 1) {
      final favouriteMeals = ref.watch(favouriteMealProvider);
      label = "Favourites";
      active = Meals(
        meals: favouriteMeals,
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
