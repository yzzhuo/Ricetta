import 'package:Ricetta/models/category.dart';

class Ingredient {
  String name;
  String quantity;

  Ingredient({
    required this.name,
    required this.quantity,
  });

  set(String key, String value) {
    if (key == 'name') {
      name = value;
    } else if (key == 'quantity') {
      quantity = value;
    }
  }

  @override
  String toString() {
    // Customize the output format as needed
    return 'Ingredient: $name, Quantity: $quantity';
  }
}

class Recipe {
  String? id;
  RecipeCategory? category;
  String title;
  String imageUrl;
  List<Ingredient> ingredients;
  List<String> steps;
  String categoryId;
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

  @override
  String toString() {
    // Customize the output format as needed
    return 'Recipe: $title, imageUrl: $imageUrl, Ingredients: ${ingredients.map((i) => i.toString())}, steps: $steps, categoryId:$categoryId';
  }

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
