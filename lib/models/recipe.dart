import 'package:Ricetta/models/category.dart';

class Ingredient {
  final String name;
  final String quantity;

  Ingredient({
    required this.name,
    required this.quantity,
  });
}

class Recipe {
  String? id;
  RecipeCategory? category;
  final String title;
  final String imageUrl;
  final List<Ingredient> ingredients;
  final List<String> steps;
  final String categoryId;
  late bool isFavourite;

  Recipe({
    required this.title,
    required this.imageUrl,
    required this.ingredients,
    required this.steps,
    this.category,
    required this.categoryId,
    this.id,
    this.isFavourite = false,
  });

  factory Recipe.fromFirestore(
      Map<String, dynamic> data, List<RecipeCategory> category, String id,
      {bool isFavourite = false}) {
    return Recipe(
      id: id,
      title: data['title'],
      imageUrl: data['imageUrl'],
      ingredients: (data['ingredients'] as List)
          .map((e) => Ingredient(name: e['name'], quantity: e['quantity']))
          .toList(),
      steps: (data['steps'] as List).map((e) => e.toString()).toList(),
      category: category.firstWhere((cat) => cat.id == data['categoryId']),
      categoryId: data['categoryId'],
      isFavourite: isFavourite,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'imageUrl': imageUrl,
      'ingredients': ingredients
          .map((e) => {'name': e.name, 'quantity': e.quantity})
          .toList(),
      'steps': steps,
      'categoryId': categoryId,
    };
  }
}
