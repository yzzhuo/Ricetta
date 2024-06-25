import 'package:Ricetta/widgets/feature_recipe_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RecipeCategoryDetailScreen extends StatelessWidget {
  late String categoryName = 'Starter';
  RecipeCategoryDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(height: 24.0),
      Container(
        alignment: Alignment.centerLeft,
        child: Text(categoryName,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              height: 0,
            )),
      ),
      const SizedBox(height: 24.0),
      // Expanded(
      //     child: ListView(
      //   children: recipes
      //       .map((recipe) => Padding(
      //           padding: const EdgeInsets.only(bottom: 12.0),
      //           child: FeatureRecipeWidget(recipe: recipe)))
      //       .toList(),
      // )),
    ]);
  }
}
