import 'package:flutter/material.dart';
import 'package:meals/Models/meal.dart';
import 'package:transparent_image/transparent_image.dart';

class MealListItem extends StatelessWidget {
  const MealListItem({super.key, required this.meal,required this.singleMeal});
  final Function() singleMeal;
  final Meal meal;
  String get complexityText{
    return meal.complexity.name[0].toUpperCase() + meal.complexity.name.substring(1);
  }
  String get affordableText{
    return meal.affordability.name[0].toUpperCase() + meal.affordability.name.substring(1);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: singleMeal,
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                color: Color(0xdc000000),
                child: Column(
                  children: [
                    Text(meal.title,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.access_time),
                              const SizedBox(
                                width: 2,
                              ),
                              Text(
                                '${meal.duration} min',
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              const Icon(Icons.work),
                              const SizedBox(
                                width: 2,
                              ),
                              Text(
                                complexityText,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              const Icon(Icons.attach_money),
                              const SizedBox(
                                width: 2,
                              ),
                              Text(
                                affordableText,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
