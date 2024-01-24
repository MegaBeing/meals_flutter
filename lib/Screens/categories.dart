import 'package:flutter/material.dart';
import 'package:meals/Data/dummy_data.dart';
import 'package:meals/Models/category.dart';
import 'package:meals/Models/meal.dart';
import 'package:meals/Screens/meals.dart';
import 'package:meals/Widgets/category_grid_item.dart';

class Categories extends StatefulWidget {
  const Categories({super.key, required this.filteredList});

  final List<Meal> filteredList;

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 300,
      ),
      upperBound: 1,
      lowerBound: 0,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final List<Meal> meals = [];
    for (final meal in widget.filteredList) {
      if (meal.categories.contains(category.id)) {
        meals.add(meal);
      }
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => Meals(
          title: category.title,
          meals: meals,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnimatedBuilder(
        animation: _animationController,
        child: GridView(
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
        ),
        builder: (context, child) => Padding(
            padding: EdgeInsets.only(top: 100 - _animationController.value * 100),
            child: child));
  }
}
