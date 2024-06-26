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

  Recipe({
    required this.title,
    required this.imageUrl,
    required this.ingredients,
    required this.steps,
    this.category,
    required this.categoryId,
    this.id,
  });

  factory Recipe.fromFirestore(
      Map<String, dynamic> data, List<RecipeCategory> category, String id) {
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

var recipes = [
  Recipe(
    title: 'Pizza',
    imageUrl:
        'https://images.pexels.com/photos/1653877/pexels-photo-1653877.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    ingredients: [
      Ingredient(name: 'Pizza Base', quantity: '1'),
      Ingredient(name: 'Tomato Sauce', quantity: '1/2 cup'),
      Ingredient(name: 'Cheese', quantity: '1/2 cup'),
      Ingredient(name: 'Onion', quantity: '1'),
      Ingredient(name: 'Capsicum', quantity: '1'),
      Ingredient(name: 'Tomato', quantity: '1'),
      Ingredient(name: 'Oregano', quantity: '1tsp'),
      Ingredient(name: 'Chilli Flakes', quantity: '1tsp'),
    ],
    categoryId: 'jqayayyBSUEX7G4t8cch',
    steps: [
      'Spread tomato sauce on the pizza base.',
      'Add cheese, onion, capsicum, and tomato.',
      'Sprinkle oregano and chilli flakes.',
      'Bake in a preheated oven at 180°C for 15 minutes.',
      'Serve hot.',
    ],
  ),
  Recipe(
    title: 'Spaghetti Carbonara',
    imageUrl:
        'https://images.pexels.com/photos/2347311/pexels-photo-2347311.jpeg',
    ingredients: [
      Ingredient(name: 'Spaghetti', quantity: '400g'),
      Ingredient(name: 'Bacon', quantity: '150g'),
      Ingredient(name: 'Eggs', quantity: '3'),
      Ingredient(name: 'Parmesan Cheese', quantity: '1 cup'),
      Ingredient(name: 'Garlic', quantity: '1 clove'),
      Ingredient(name: 'Salt', quantity: 'to taste'),
      Ingredient(name: 'Pepper', quantity: 'to taste'),
    ],
    categoryId: 'jqayayyBSUEX7G4t8cch',
    steps: [
      'Cook spaghetti according to package instructions.',
      'Fry bacon and garlic until crispy.',
      'Whisk together eggs and Parmesan.',
      'Combine spaghetti, bacon, and egg mixture.',
      'Season with salt and pepper.',
      'Serve immediately.',
    ],
  ),
  Recipe(
    title: 'Chicken Curry',
    imageUrl:
        'https://images.pexels.com/photos/674574/pexels-photo-674574.jpeg',
    ingredients: [
      Ingredient(name: 'Chicken', quantity: '1 kg'),
      Ingredient(name: 'Onion', quantity: '2'),
      Ingredient(name: 'Tomato', quantity: '2'),
      Ingredient(name: 'Garlic', quantity: '4 cloves'),
      Ingredient(name: 'Ginger', quantity: '1 inch'),
      Ingredient(name: 'Curry Powder', quantity: '2 tbsp'),
      Ingredient(name: 'Coconut Milk', quantity: '1 cup'),
      Ingredient(name: 'Salt', quantity: 'to taste'),
    ],
    categoryId: 'jqayayyBSUEX7G4t8cch',
    steps: [
      'Saute onion, garlic, and ginger.',
      'Add chicken and brown.',
      'Stir in curry powder and tomato.',
      'Pour in coconut milk and simmer.',
      'Season with salt.',
      'Serve with rice.',
    ],
  ),
  Recipe(
    title: 'Beef Stew',
    imageUrl:
        'https://images.pexels.com/photos/2313686/pexels-photo-2313686.jpeg',
    ingredients: [
      Ingredient(name: 'Beef', quantity: '1 kg'),
      Ingredient(name: 'Carrots', quantity: '3'),
      Ingredient(name: 'Potatoes', quantity: '3'),
      Ingredient(name: 'Onion', quantity: '1'),
      Ingredient(name: 'Beef Broth', quantity: '4 cups'),
      Ingredient(name: 'Tomato Paste', quantity: '2 tbsp'),
      Ingredient(name: 'Garlic', quantity: '2 cloves'),
      Ingredient(name: 'Thyme', quantity: '1 tsp'),
      Ingredient(name: 'Salt', quantity: 'to taste'),
      Ingredient(name: 'Pepper', quantity: 'to taste'),
    ],
    categoryId: 'jqayayyBSUEX7G4t8cch',
    steps: [
      'Brown beef in a pot.',
      'Add chopped vegetables and garlic.',
      'Stir in broth, tomato paste, and thyme.',
      'Simmer until beef and vegetables are tender.',
      'Season with salt and pepper.',
      'Serve hot.',
    ],
  ),
  // Starter Category
  Recipe(
    title: 'Bruschetta',
    imageUrl:
        'https://images.pexels.com/photos/5639411/pexels-photo-5639411.jpeg',
    ingredients: [
      Ingredient(name: 'Bread', quantity: '4 slices'),
      Ingredient(name: 'Tomato', quantity: '2'),
      Ingredient(name: 'Garlic', quantity: '1 clove'),
      Ingredient(name: 'Basil', quantity: '6 leaves'),
      Ingredient(name: 'Olive Oil', quantity: '2 tbsp'),
      Ingredient(name: 'Salt', quantity: 'to taste'),
    ],
    categoryId: 'LDTTpzWuoVJD25ApeTYw',
    steps: [
      'Toast bread slices.',
      'Mix chopped tomatoes, garlic, basil, olive oil, and salt.',
      'Top toasted bread with tomato mixture.',
      'Serve immediately.',
    ],
  ),
  Recipe(
    title: 'Garlic Knots',
    imageUrl:
        'https://images.pexels.com/photos/4377544/pexels-photo-4377544.jpeg',
    ingredients: [
      Ingredient(name: 'Pizza Dough', quantity: '1 lb'),
      Ingredient(name: 'Butter', quantity: '4 tbsp'),
      Ingredient(name: 'Garlic', quantity: '3 cloves'),
      Ingredient(name: 'Parsley', quantity: '2 tbsp'),
      Ingredient(name: 'Salt', quantity: '1 tsp'),
    ],
    categoryId: 'LDTTpzWuoVJD25ApeTYw',
    steps: [
      'Cut pizza dough into strips and tie into knots.',
      'Bake until golden brown.',
      'Mix melted butter, minced garlic, parsley, and salt.',
      'Toss baked knots in garlic butter mixture.',
      'Serve warm.',
    ],
  ),
  Recipe(
    title: 'Caprese Salad',
    imageUrl:
        'https://images.pexels.com/photos/257816/pexels-photo-257816.jpeg',
    ingredients: [
      Ingredient(name: 'Tomato', quantity: '3'),
      Ingredient(name: 'Mozzarella Cheese', quantity: '200g'),
      Ingredient(name: 'Basil', quantity: '1 bunch'),
      Ingredient(name: 'Olive Oil', quantity: 'to drizzle'),
      Ingredient(name: 'Balsamic Glaze', quantity: 'to drizzle'),
      Ingredient(name: 'Salt', quantity: 'to taste'),
    ],
    categoryId: 'LDTTpzWuoVJD25ApeTYw',
    steps: [
      'Slice tomatoes and mozzarella.',
      'Arrange tomato, mozzarella, and basil alternately on a plate.',
      'Drizzle with olive oil and balsamic glaze.',
      'Sprinkle with salt.',
      'Serve chilled.',
    ],
  ),
  // Dessert
  Recipe(
    title: 'Chocolate Cake',
    imageUrl:
        'https://images.pexels.com/photos/2144200/pexels-photo-2144200.jpeg',
    ingredients: [
      Ingredient(name: 'Flour', quantity: '2 cups'),
      Ingredient(name: 'Sugar', quantity: '2 cups'),
      Ingredient(name: 'Cocoa Powder', quantity: '3/4 cup'),
      Ingredient(name: 'Baking Powder', quantity: '2 tsp'),
      Ingredient(name: 'Baking Soda', quantity: '1 1/2 tsp'),
      Ingredient(name: 'Salt', quantity: '1 tsp'),
      Ingredient(name: 'Eggs', quantity: '2'),
      Ingredient(name: 'Milk', quantity: '1 cup'),
      Ingredient(name: 'Vegetable Oil', quantity: '1/2 cup'),
      Ingredient(name: 'Vanilla Extract', quantity: '2 tsp'),
      Ingredient(name: 'Boiling Water', quantity: '1 cup'),
    ],
    categoryId: 'M6rrQZ74mJOcoFFDrcKN',
    steps: [
      'Mix dry ingredients together.',
      'Add eggs, milk, oil, and vanilla. Beat until smooth.',
      'Stir in boiling water (batter will be thin).',
      'Pour into prepared pans and bake.',
      'Cool and frost as desired.',
    ],
  ),
  Recipe(
    title: 'Cheesecake',
    imageUrl:
        'https://images.pexels.com/photos/3071821/pexels-photo-3071821.jpeg',
    ingredients: [
      Ingredient(name: 'Cream Cheese', quantity: '2 lbs'),
      Ingredient(name: 'Sugar', quantity: '1 cup'),
      Ingredient(name: 'Vanilla Extract', quantity: '1 tsp'),
      Ingredient(name: 'Eggs', quantity: '4'),
      Ingredient(name: 'Sour Cream', quantity: '1 cup'),
      Ingredient(name: 'Graham Cracker Crust', quantity: '1'),
    ],
    categoryId: 'M6rrQZ74mJOcoFFDrcKN',
    steps: [
      'Beat cream cheese, sugar, and vanilla until smooth.',
      'Add eggs one at a time.',
      'Blend in sour cream.',
      'Pour into crust and bake.',
      'Chill before serving.',
    ],
  ),
  Recipe(
    title: 'Tiramisu',
    imageUrl:
        'https://images.pexels.com/photos/6880219/pexels-photo-6880219.jpeg',
    ingredients: [
      Ingredient(name: 'Espresso', quantity: '1 cup'),
      Ingredient(name: 'Ladyfingers', quantity: '24'),
      Ingredient(name: 'Mascarpone Cheese', quantity: '1 lb'),
      Ingredient(name: 'Sugar', quantity: '3/4 cup'),
      Ingredient(name: 'Cocoa Powder', quantity: 'for dusting'),
      Ingredient(name: 'Dark Chocolate', quantity: 'for shaving'),
    ],
    categoryId: 'M6rrQZ74mJOcoFFDrcKN',
    steps: [
      'Dip ladyfingers in espresso and layer in a dish.',
      'Mix mascarpone with sugar and spread over ladyfingers.',
      'Repeat layers.',
      'Dust with cocoa and chocolate shavings.',
      'Chill before serving.',
    ],
  ),
  Recipe(
    title: 'Mango Smoothie',
    imageUrl:
        'https://images.pexels.com/photos/8211179/pexels-photo-8211179.jpeg',
    ingredients: [
      Ingredient(name: 'Mango', quantity: '2 cups'),
      Ingredient(name: 'Yogurt', quantity: '1 cup'),
      Ingredient(name: 'Honey', quantity: '2 tbsp'),
      Ingredient(name: 'Milk', quantity: '1/2 cup'),
    ],
    categoryId: 'MVWkNVFMcyrxmgJEg9ns',
    steps: [
      'Combine all ingredients in a blender.',
      'Blend until smooth.',
      'Serve chilled.',
    ],
  ),
  Recipe(
    title: 'Iced Coffee',
    imageUrl:
        'https://images.pexels.com/photos/1193335/pexels-photo-1193335.jpeg',
    ingredients: [
      Ingredient(name: 'Coffee', quantity: '1 cup'),
      Ingredient(name: 'Milk', quantity: '1/2 cup'),
      Ingredient(name: 'Ice Cubes', quantity: 'as needed'),
      Ingredient(name: 'Sugar', quantity: 'to taste'),
    ],
    categoryId: 'MVWkNVFMcyrxmgJEg9ns',
    steps: [
      'Brew coffee and let it cool.',
      'Fill a glass with ice cubes.',
      'Pour in coffee and milk.',
      'Sweeten with sugar as desired.',
      'Serve immediately.',
    ],
  ),
  Recipe(
    title: 'Green Tea',
    imageUrl:
        'https://images.pexels.com/photos/814264/pexels-photo-814264.jpeg',
    ingredients: [
      Ingredient(name: 'Green Tea Leaves', quantity: '1 tsp'),
      Ingredient(name: 'Water', quantity: '1 cup'),
      Ingredient(name: 'Honey', quantity: 'to taste'),
    ],
    categoryId: 'MVWkNVFMcyrxmgJEg9ns',
    steps: [
      'Boil water and pour over green tea leaves.',
      'Steep for 3 minutes.',
      'Strain and sweeten with honey.',
      'Serve hot or chilled.',
    ],
  ),
  Recipe(
    title: 'Pancakes',
    imageUrl:
        'https://images.pexels.com/photos/376464/pexels-photo-376464.jpeg',
    ingredients: [
      Ingredient(name: 'Flour', quantity: '2 cups'),
      Ingredient(name: 'Milk', quantity: '1 1/2 cups'),
      Ingredient(name: 'Egg', quantity: '1'),
      Ingredient(name: 'Butter', quantity: '2 tbsp'),
      Ingredient(name: 'Sugar', quantity: '1 tbsp'),
      Ingredient(name: 'Baking Powder', quantity: '2 tsp'),
      Ingredient(name: 'Salt', quantity: '1/2 tsp'),
    ],
    categoryId: 'RSgUdJ8V6omHITbgsDA0',
    steps: [
      'Mix dry ingredients together.',
      'Whisk in milk, egg, and melted butter.',
      'Pour batter onto a hot griddle.',
      'Cook until bubbles form, then flip.',
      'Serve with syrup.',
    ],
  ),
  Recipe(
    title: 'Omelette',
    imageUrl:
        'https://images.pexels.com/photos/1437268/pexels-photo-1437268.jpeg',
    ingredients: [
      Ingredient(name: 'Eggs', quantity: '2'),
      Ingredient(name: 'Milk', quantity: '2 tbsp'),
      Ingredient(name: 'Salt', quantity: 'to taste'),
      Ingredient(name: 'Pepper', quantity: 'to taste'),
      Ingredient(name: 'Butter', quantity: '1 tbsp'),
      Ingredient(name: 'Cheese', quantity: 'optional'),
    ],
    categoryId: 'RSgUdJ8V6omHITbgsDA0',
    steps: [
      'Whisk eggs, milk, salt, and pepper.',
      'Melt butter in a pan.',
      'Pour in egg mixture and cook until set.',
      'Add cheese if desired, fold, and serve.',
    ],
  ),
  Recipe(
    title: 'French Toast',
    imageUrl:
        'https://images.pexels.com/photos/5531701/pexels-photo-5531701.jpeg',
    ingredients: [
      Ingredient(name: 'Bread', quantity: '4 slices'),
      Ingredient(name: 'Egg', quantity: '1'),
      Ingredient(name: 'Milk', quantity: '1/3 cup'),
      Ingredient(name: 'Cinnamon', quantity: '1 tsp'),
      Ingredient(name: 'Vanilla Extract', quantity: '1 tsp'),
      Ingredient(name: 'Butter', quantity: 'for frying'),
    ],
    categoryId: 'RSgUdJ8V6omHITbgsDA0',
    steps: [
      'Whisk together egg, milk, cinnamon, and vanilla.',
      'Dip bread slices in the mixture.',
      'Fry in butter until golden brown.',
      'Serve with syrup or fruit.',
    ],
  ),
];
