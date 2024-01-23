import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Data/dummy_data.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false
        });

  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    // state[filter] = isActive; // not allowed! => mutating state
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
        (ref) => FiltersNotifier());

final filtersMealProvider = Provider((ref) {
  final activeFilters = ref.watch(filtersProvider);
  return dummyMeals.where((meal) {
    if (!meal.isGlutenFree && activeFilters[Filter.glutenFree]!) {
      return false;
    }
    if (!meal.isLactoseFree && activeFilters[Filter.lactoseFree]!) {
      return false;
    }
    if (!meal.isVegan && activeFilters[Filter.vegan]!) {
      return false;
    }
    if (!meal.isVegetarian && activeFilters[Filter.vegetarian]!) {
      return false;
    }
    return true;
  }).toList();
});
