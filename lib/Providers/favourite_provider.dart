import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/Models/meal.dart';

class FavouriteMealNavigator extends StateNotifier<List<Meal>> {
  FavouriteMealNavigator() : super([]);

  // cannot directly edit the state list but we can reinitialize it
  bool toggleMealFavouriteStatus(Meal meal) {
    final isMealFavourite = state.contains(meal);
    if (isMealFavourite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favouriteMealProvider =
    StateNotifierProvider<FavouriteMealNavigator, List<Meal>>(
  (ref) => FavouriteMealNavigator(),
);
