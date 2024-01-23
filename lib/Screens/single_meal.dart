import 'package:flutter/material.dart';
import 'package:meals/Models/meal.dart';
import 'package:meals/Widgets/single_meal_item.dart';

class SingleMeal extends StatelessWidget {
  const SingleMeal({super.key, required this.singleMeal,required this.setFavouriteState});

  final Meal singleMeal;
  final void Function(Meal meal) setFavouriteState;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(singleMeal.title.toString()),
      actions: [
        IconButton(onPressed: (){setFavouriteState(singleMeal);}, icon: const Icon(Icons.star))
      ],),
      body: SingleMealItem(
        singleMeal: singleMeal,
      ),
    );
  }
}
