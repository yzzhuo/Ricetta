import 'package:Ricetta/models/receipe.dart';
import 'package:Ricetta/widgets/feature_recipe_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '/widgets/category_card.dart';
import '/providers/category_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(child: FeatureRecipesWidget(recipes: recipes)),
      const Expanded(child: CategoriesList())
    ]);
  }
}

class FeatureRecipesWidget extends StatelessWidget {
  const FeatureRecipesWidget({super.key, required this.recipes});
  final List<Recipe> recipes;

  @override
  Widget build(BuildContext context) {
    List<Recipe> lastFiveRecipes;

    // Get the last 5 recipes
    if (recipes.length <= 5) {
      lastFiveRecipes =
          List.from(recipes); // If there are 5 or fewer items, take them all
    } else {
      int startIndex = recipes.length - 5;
      lastFiveRecipes = recipes.sublist(startIndex);
    }
    return Column(
      children: [
        Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'Feature Recipes',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
            )),
        const SizedBox(height: 12.0),
        SizedBox(
            height: 284,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: lastFiveRecipes
                  .map((recipe) => FeatureRecipeWidget(recipe: recipe))
                  .toList(),
            )),
      ],
    );
  }
}

class CategoriesList extends ConsumerWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(recipeCategoriesProvider);

    return Column(children: [
      Container(
        margin: const EdgeInsets.only(top: 24.0),
        alignment: Alignment.centerLeft,
        child: Row(children: [
          const Text(
            'Categories',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          IconButton(
              onPressed: () {
                context.push('/category');
              },
              icon: const Icon(Icons.arrow_forward_ios)),
        ]),
      ),
      const SizedBox(height: 12.0),
      Expanded(
          child: ListView.separated(
              itemCount:
                  3, // Replace 'items.length' with the actual length of your list
              separatorBuilder: (context, index) {
                return const SizedBox(
                    height:
                        10); // Adjust the height for desired space between items
              },
              itemBuilder: (content, index) {
                final category = categories[index];
                return CategoryCard(category: category);
              }))
    ]);
  }
}
