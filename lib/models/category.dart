class RecipeCategory {
  final String name;
  final String image;

  RecipeCategory({required this.name, required this.image});

  factory RecipeCategory.fromJson(Map<String, dynamic> json) {
    return RecipeCategory(
      name: json['name'],
      image: json['image'],
    );
  }
}

var categories = [
  RecipeCategory(
      name: 'Starter',
      image: 'gs://flutter-recipe-app-fa71f.appspot.com/category/starter.png'),
  RecipeCategory(
      name: 'Main',
      image: 'gs://flutter-recipe-app-fa71f.appspot.com/category/main.png'),
  RecipeCategory(
      name: 'Dessert',
      image: 'gs://flutter-recipe-app-fa71f.appspot.com/category/dessert.png'),
  RecipeCategory(
      name: 'Snack',
      image: 'gs://flutter-recipe-app-fa71f.appspot.com/category/snack.png'),
  RecipeCategory(
      name: 'Breakfast',
      image:
          'gs://flutter-recipe-app-fa71f.appspot.com/category/breakfast.png'),
  RecipeCategory(
      name: 'Drink',
      image: 'gs://flutter-recipe-app-fa71f.appspot.com/category/drink.png'),
];
