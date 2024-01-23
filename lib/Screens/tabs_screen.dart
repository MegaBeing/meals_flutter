import 'package:flutter/material.dart';
import 'package:meals/Screens/categories.dart';
import 'package:meals/Screens/filters.dart';
import 'package:meals/Screens/meals.dart';
import 'package:meals/Widgets/main_drawer.dart';
import 'package:meals/Providers/favourite_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Providers/filters_provider.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
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

  void _setPage(int index) {
    setState(() {
      _setPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final activeFilters = ref.watch(filtersProvider);
    final availableMeals = ref.watch(filtersMealProvider);
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
