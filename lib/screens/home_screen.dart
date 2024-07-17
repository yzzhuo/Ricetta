import 'package:Ricetta/models/recipe.dart';
import 'package:Ricetta/utils/breakpoint.dart';
import 'package:Ricetta/widgets/feature_recipe_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '/widgets/category_card.dart';
import '/providers/category_provider.dart';
import '/providers/recipe_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(children: [
      Expanded(child: FeatureRecipesWidget()),
      Expanded(child: CategoriesList())
    ]);
  }
}

class FeatureRecipesWidget extends ConsumerWidget {
  const FeatureRecipesWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipeState = ref.watch(recipesProvider);
    final recipes = recipeState.recipes;
    List<Recipe> lastFiveRecipes;
    final size = MediaQuery.of(context).size;
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
        Row(children: [
          const Text(
            'Lastest Recipes',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
          ),
          IconButton(
              onPressed: () {
                context.push('/recipes');
              },
              icon: const Icon(Icons.arrow_forward_ios)),
        ]),
        const SizedBox(height: 12.0),
        SizedBox(
            height: 284,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: lastFiveRecipes
                  .map((recipe) => SizedBox(
                        width: size.width < Breakpoints.md ? null : 250,
                        child: FeatureRecipeWidget(recipe: recipe),
                      ))
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
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < Breakpoints.md;

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
          child: isMobile
              ? ListView.separated(
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
                  })
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 6,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return CategoryCard(category: category);
                  },
                ))
    ]);
  }
}
