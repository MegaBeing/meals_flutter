import 'package:flutter/material.dart';
import 'package:meals/Models/meal.dart';
import 'package:transparent_image/transparent_image.dart';

class SingleMealItem extends StatelessWidget {
  SingleMealItem({super.key, required this.singleMeal});

  final Meal singleMeal;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Column(
        children: [
          FadeInImage(
            placeholder: MemoryImage(kTransparentImage),
            image: NetworkImage(singleMeal.imageUrl),
            fit: BoxFit.cover,
            height: 300,
            width: double.infinity,
          ),
          const SizedBox(height: 25),
          Text(
            'Ingredients',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
          const SizedBox(
            height: 15,
          ),
          for (final text in singleMeal.ingredients)
            Text(
              text,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          const SizedBox(height: 25),
          Center(
            child: Text(
              'Steps',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          for (final text in singleMeal.steps)
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Text(
                '\u2022 '+text,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
