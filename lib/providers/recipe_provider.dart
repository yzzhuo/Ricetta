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
        final favouriteTotal = favouriteRecipes.docs
            .where((fav) => fav['recipeId'] == doc.id)
            .length;
        return Recipe.fromFirestore(
          doc.data(),
          categories,
          doc.id,
          isFavourite: isFavourite,
          favouriteTotal: favouriteTotal,
        );
      });
      recipes = newRecipes.toList();
    }

    state =
        RecipeState(recipes: recipes, recipe: state.recipe, isLoading: false);
  }

  getRecipeDetailById(String recipeId) async {
    state = RecipeState(isLoading: true, recipes: state.recipes, recipe: null);
    final snapshot = await _firestore.collection('recipes').doc(recipeId).get();
    final favouriteRecipes = await _firestore
        .collection('favourite_recipes')
        .where('uid', isEqualTo: user!.uid)
        .get();
    final isFavourite =
        favouriteRecipes.docs.any((fav) => fav['recipeId'] == recipeId);
    final favouriteTotal = favouriteRecipes.docs
        .where((fav) => fav['recipeId'] == recipeId)
        .length;
    final recipe = Recipe.fromFirestore(
        snapshot.data() as Map<String, dynamic>, categories, snapshot.id,
        isFavourite: isFavourite, favouriteTotal: favouriteTotal);
    state =
        RecipeState(recipes: state.recipes, recipe: recipe, isLoading: false);
    return recipe;
  }

  void updateRecipe(Recipe recipe) async {
    // only allow authenticated users to update recipes
    if (user == null) return;
    final recipeData = recipe.toFirestore();
    await _firestore.collection('recipes').doc(recipe.id).update(recipeData);
    final newRecipes = state.recipes.map((r) {
      if (r.id == recipe.id) {
        return recipe;
      }
      return r;
    }).toList();
    state = RecipeState(recipes: newRecipes, recipe: recipe);
  }

  void deleteRecipe(String recipeId) async {
    // only allow authenticated users to delete recipes
    if (user == null) return;
    await _firestore.collection('recipes').doc(recipeId).delete();
    final newRecipes = state.recipes.where((r) => r.id != recipeId).toList();
    state = RecipeState(recipes: newRecipes, recipe: state.recipe);
  }

  void addRecipe(Recipe recipe) async {
    // only allow authenticated users to add recipes
    if (user == null) return;
    final recipeData = recipe.toFirestore();
    recipeData['userId'] = user!.uid;
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
        recipe.favouriteTotal += isFavourite ? 1 : -1;
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
