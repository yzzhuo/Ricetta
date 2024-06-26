import 'package:Ricetta/models/category.dart';
import 'package:Ricetta/providers/category_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/models/recipe.dart';

class RecipeState {
  final List<Recipe> recipes;
  final Recipe? recipe;
  bool isLoading = false;
  RecipeState({required this.recipes, this.recipe, this.isLoading = false});
}

class RecipeNotifier extends StateNotifier<RecipeState> {
  final List<RecipeCategory> categories;

  RecipeNotifier({required this.categories})
      : super(RecipeState(recipes: [], recipe: null)) {
    _fetchrecipes();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _fetchrecipes() async {
    if (categories.isEmpty) return;
    state = RecipeState(
        recipes: state.recipes, recipe: state.recipe, isLoading: true);
    final snapshot = await _firestore.collection('recipes').get();
    final recipes = snapshot.docs
        .map((doc) => Recipe.fromFirestore(doc.data(), categories, doc.id))
        .toList();
    state =
        RecipeState(recipes: recipes, recipe: state.recipe, isLoading: false);
  }

  void getRecipeDetailById(String recipeId) async {
    state = RecipeState(isLoading: true, recipes: state.recipes, recipe: null);
    final snapshot = await _firestore.collection('recipes').doc(recipeId).get();
    final recipe = Recipe.fromFirestore(
        snapshot.data() as Map<String, dynamic>, categories, snapshot.id);
    state =
        RecipeState(recipes: state.recipes, recipe: recipe, isLoading: false);
  }

  void addRecipe(Recipe recipe) async {
    final recipeData = recipe.toFirestore();
    final recipeRef = await _firestore.collection('recipes').add(recipeData);
    final newRecipe =
        Recipe.fromFirestore(recipeData, categories, recipeRef.id);
    state = RecipeState(
        recipes: [...state.recipes, newRecipe], recipe: state.recipe);
  }
}

final recipesProvider =
    StateNotifierProvider<RecipeNotifier, RecipeState>((ref) {
  final asyncCategory = ref.watch(recipeCategoriesProvider);
  return RecipeNotifier(categories: asyncCategory);
});
