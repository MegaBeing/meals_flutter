import 'package:flutter/material.dart';
import 'package:meals/Data/dummy_data.dart';
import 'package:meals/Models/category.dart';
import 'package:meals/Models/meal.dart';
import 'package:meals/Screens/meals.dart';
import 'package:meals/Widgets/category_grid_item.dart';

class Categories extends StatelessWidget {
  const Categories(
      {super.key, required this.setFavouriteState});

  final void Function(Meal meal) setFavouriteState;
  void _selectCategory(BuildContext context, Category category) {
    final List<Meal> meals = [];
    for (final meal in dummyMeals) {
      if (meal.categories.contains(category.id)) {
        meals.add(meal);
      }
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => Meals(
          title: category.title,
          meals: meals,
          setFavouriteState: setFavouriteState,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      children: [
        ...availableCategories.map(
              (category) {
            return CategoryGridItem(
              category: category,
              onSelectCategory: () {
                _selectCategory(context, category);
              },
            );
          },
        ),
      ],
    );
  }
}
