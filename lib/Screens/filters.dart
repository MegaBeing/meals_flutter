import 'package:flutter/material.dart';

enum Filters { glutenFree, lactosFree, vegetarian, vegan }

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key,required this.currentFilters});
  final Map<Filters,bool> currentFilters;
  @override
  State<FiltersScreen> createState() {
    // TODO: implement createState
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFreeFilter = false;
  bool _lactosFreeFilter = false;
  bool _vegetarianFilter = false;
  bool _veganFilter = false;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _glutenFreeFilter = widget.currentFilters[Filters.glutenFree]!;
    _lactosFreeFilter = widget.currentFilters[Filters.lactosFree]!;
    _vegetarianFilter = widget.currentFilters[Filters.vegetarian]!;
    _veganFilter = widget.currentFilters[Filters.vegan]!;

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return PopScope(
      canPop:false,
      onPopInvoked: (bool isLeaving) async {
        if (isLeaving) return;
        return Navigator.of(context).pop({
          Filters.glutenFree: _glutenFreeFilter,
          Filters.lactosFree: _lactosFreeFilter,
          Filters.vegetarian: _vegetarianFilter,
          Filters.vegan: _veganFilter,
        });
      },
      child: Scaffold(
        // drawer: MainDrawer(
        //   onSelectScreen: (String identifier) {
        //     Navigator.of(context).pop();
        //     if (identifier == 'meals') {
        //       Navigator.of(context).pushReplacement(
        //         MaterialPageRoute(
        //           builder: (context) => const TabsScreen(),
        //         ),
        //       );
        //     }
        //   },
        // ),
        appBar: AppBar(
          title: const Text('filters'),
        ),
        body: Column(
          children: [
            SwitchListTile(
              value: _glutenFreeFilter,
              onChanged: (isChecked) {
                setState(() {
                  _glutenFreeFilter = isChecked;
                });
              },
              title: Text(
                'Gluten Free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                'Only include gluten-free meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 32, right: 22),
            ),
            SwitchListTile(
              value: _lactosFreeFilter,
              onChanged: (isChecked) {
                setState(() {
                  _lactosFreeFilter = isChecked;
                });
              },
              title: Text(
                'Lactose Free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                'Only include lactos-free meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 32, right: 22),
            ),
            SwitchListTile(
              value: _vegetarianFilter,
              onChanged: (isChecked) {
                setState(() {
                  _vegetarianFilter = isChecked;
                });
              },
              title: Text(
                'Vegetarian',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                'Only include vegetarian meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 32, right: 22),
            ),
            SwitchListTile(
              value: _veganFilter,
              onChanged: (isChecked) {
                setState(() {
                  _veganFilter = isChecked;
                });
              },
              title: Text(
                'Vegan',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                'Only include vegan meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 32, right: 22),
            ),
          ],
        ),
      ),
    );
  }
}
