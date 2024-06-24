class Ingredient {
  final String name;
  final String quantity;

  Ingredient({
    required this.name,
    required this.quantity,
  });
}

class Recipe {
  final String title;
  final String imageUrl;
  final String description;
  final List<Ingredient> ingredients;
  final List<String> steps;

  Recipe({
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.ingredients,
    required this.steps,
  });
}

var recipes = [
  Recipe(
    title: 'Pasta',
    imageUrl:
        'https://images.pexels.com/photos/1279330/pexels-photo-1279330.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    description:
        'Pasta is a type of food typically made from an unleavened dough of wheat flour mixed with water or eggs, and formed into sheets or other shapes, then cooked by boiling or baking. Rice flour, or legumes such as beans or lentils, are sometimes used in place of wheat flour to yield a different taste and texture, or as a gluten-free alternative.',
    ingredients: [
      Ingredient(name: 'Pasta', quantity: '200g'),
      Ingredient(name: 'Tomato', quantity: '2'),
      Ingredient(name: 'Onion', quantity: '1'),
      Ingredient(name: 'Garlic', quantity: '2'),
      Ingredient(name: 'Olive Oil', quantity: '2tbsp'),
      Ingredient(name: 'Salt', quantity: '1tsp'),
      Ingredient(name: 'Pepper', quantity: '1tsp'),
    ],
    steps: [
      'Boil the pasta in water with salt and oil.',
      'Chop the tomato, onion, and garlic.',
      'Heat oil in a pan and add garlic and onion.',
      'Add tomato and cook for 5 minutes.',
      'Add salt and pepper.',
      'Add the boiled pasta and mix well.',
      'Serve hot.',
    ],
  ),
  Recipe(
    title: 'Pizza',
    imageUrl:
        'https://images.pexels.com/photos/1653877/pexels-photo-1653877.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    description:
        'Pizza is a savory dish of Italian origin consisting of a usually round, flattened base of leavened wheat-based dough topped with tomatoes, cheese, and often various other ingredients baked at a high temperature, traditionally in a wood-fired oven.',
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
    steps: [
      'Spread tomato sauce on the pizza base.',
      'Add cheese, onion, capsicum, and tomato.',
      'Sprinkle oregano and chilli flakes.',
      'Bake in a preheated oven at 180°C for 15 minutes.',
      'Serve hot.',
    ],
  )
];
