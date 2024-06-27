import 'package:Ricetta/models/category.dart';
import 'package:Ricetta/providers/category_provider.dart';
import 'package:Ricetta/providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final User? user;

  RecipeNotifier({required this.categories, this.user})
      : super(RecipeState(recipes: [], recipe: null)) {
    _fetchRecipes();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _fetchRecipes() async {
    if (categories.isEmpty) return;
    state = RecipeState(
        recipes: state.recipes, recipe: state.recipe, isLoading: true);
    final snapshot = await _firestore.collection('recipes').get();
    List<Recipe> recipes = snapshot.docs
        .map((doc) => Recipe.fromFirestore(doc.data(), categories, doc.id))
        .toList();

    if (user != null) {
      final favouriteRecipes = await _firestore
          .collection('favourite_recipes')
          .where('uid', isEqualTo: user!.uid)
          .get();
      final newRecipes = snapshot.docs.map((doc) {
        final isFavourite =
            favouriteRecipes.docs.any((fav) => fav['recipeId'] == doc.id);
        return Recipe.fromFirestore(
          doc.data(),
          categories,
          doc.id,
          isFavourite: isFavourite,
        );
      });
      recipes = newRecipes.toList();
    }

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

  addFavoriteRecipe(String recipeId, String userId, bool isFavourite) async {
    if (isFavourite) {
      await _firestore.collection('favourite_recipes').add({
        'uid': userId,
        'recipeId': recipeId,
      });
    } else {
      // delete favourite recipe
      final snapshot = await _firestore
          .collection('favourite_recipes')
          .where('uid', isEqualTo: userId)
          .where('recipeId', isEqualTo: recipeId)
          .get();
      final docId = snapshot.docs.first.id;
      await _firestore.collection('favourite_recipes').doc(docId).delete();
    }
    // update the recipe list
    final newRecipes = state.recipes.map((recipe) {
      if (recipe.id == recipeId) {
        recipe.isFavourite = isFavourite;
      }
      return recipe;
    }).toList();
    state = RecipeState(recipes: newRecipes, recipe: state.recipe);
  }
}

final recipesProvider =
    StateNotifierProvider<RecipeNotifier, RecipeState>((ref) {
  final asyncCategory = ref.watch(recipeCategoriesProvider);
  final userState = ref.watch(userProvider);
  return RecipeNotifier(categories: asyncCategory, user: userState);
});
