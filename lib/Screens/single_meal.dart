import 'package:flutter/material.dart';
import 'package:meals/Models/meal.dart';
import 'package:meals/Providers/favourite_provider.dart';
import 'package:meals/Widgets/single_meal_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SingleMeal extends ConsumerWidget {
  const SingleMeal({super.key, required this.singleMeal});

  final Meal singleMeal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(singleMeal.title.toString()),
        actions: [
          IconButton(
              onPressed: () {
                var isAdded = ref
                    .read(favouriteMealProvider.notifier)
                    .toggleMealFavouriteStatus(singleMeal);
                var message = '';
                if(isAdded){
                  message='New favourite added';
                }
                else{
                  message='Removed from Favourites';
                }
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                  ),
                );
              },
              icon: const Icon(Icons.star))
        ],
      ),
      body: SingleMealItem(
        singleMeal: singleMeal,
      ),
    );
  }
}
