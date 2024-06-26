import 'package:Ricetta/providers/category_provider.dart';
import 'package:Ricetta/providers/recipe_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Ricetta/widgets/feature_recipe_widget.dart';
import 'package:flutter/material.dart';

class RecipeCategoryDetailScreen extends ConsumerStatefulWidget {
  final String categoryId;
  const RecipeCategoryDetailScreen({super.key, required this.categoryId});

  @override
  _RecipeCategoryDetailState createState() => _RecipeCategoryDetailState();
}

class _RecipeCategoryDetailState
    extends ConsumerState<RecipeCategoryDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recipeState = ref.watch(recipesProvider);
    final categoryState = ref.watch(recipeCategoriesProvider);
    final categoryName = categoryState
        .firstWhere((category) => category.id == widget.categoryId)
        .name;
    final currentRecipes = recipeState.recipes
        .where((recipe) => recipe.categoryId == widget.categoryId)
        .toList();

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
      recipeState.isLoading
          ? const Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : (currentRecipes.isEmpty
              ? const Expanded(
                  child: Center(
                  child: Text('No recipes found for this category'),
                ))
              : Expanded(
                  child: ListView(
                  children: currentRecipes
                      .map((recipe) => Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: FeatureRecipeWidget(recipe: recipe)))
                      .toList(),
                ))),
    ]);
  }
}
