import 'package:flutter/material.dart';
import 'package:meals/Screens/single_meal.dart';
import 'package:meals/Widgets/meal_list_item.dart';
import '../Models/meal.dart';

class Meals extends StatelessWidget {
  const Meals({super.key, this.title, required this.meals});

  final String? title;
  final List<Meal> meals;

  void _singleMeal(BuildContext context, Meal singleMeal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => SingleMeal(
          singleMeal: singleMeal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Widget body = Center(
      child: Text(
        'Nothing to see here',
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
    );
    if (meals.isNotEmpty) {
      body = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (context, index) => MealListItem(
          meal: meals[index],
          singleMeal: () {
            _singleMeal(context, meals[index]);
          },
        ),
      );
    }
    if (title == null) {
      return body;
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(title!),
        ),
        body: body);
  }
}
