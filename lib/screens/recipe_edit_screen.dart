import 'package:Ricetta/models/category.dart';
import 'package:Ricetta/models/recipe.dart';
import 'package:Ricetta/providers/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Recipe defaultRecipe = Recipe(
  id: '',
  title: '',
  imageUrl: '',
  categoryId: '',
  ingredients: [
    Ingredient(name: '', quantity: ''),
    Ingredient(name: '', quantity: '')
  ],
  steps: [''],
);

class RecipeEditScreen extends ConsumerStatefulWidget {
  Recipe? recipe; // Assuming there's a Recipe model
  RecipeEditScreen({super.key, this.recipe}) {
    recipe = recipe ?? defaultRecipe;
  }

  @override
  _RecipeEditScreenState createState() => _RecipeEditScreenState();
}

class _RecipeEditScreenState extends ConsumerState<RecipeEditScreen> {
  late Recipe _editableRecipe;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;

  @override
  void initState() {
    super.initState();
    _editableRecipe = widget.recipe!;
    _titleController = TextEditingController(text: widget.recipe?.title ?? '');
    _titleController.addListener(_updateTitle);
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _updateCategory(String value) {
    // Update the category in the model
    setState(() {
      _editableRecipe.categoryId = value;
    });
  }

  void _updateTitle() {
    // Update the title in the model
    setState(() {
      _editableRecipe.title = _titleController.text;
    });
  }

  void _removeIngredient(String name) {
    // Method to remove an ingredient
    setState(() {
      _editableRecipe.ingredients
          .removeWhere((element) => element.name == name);
    });
  }

  void _removeStep(String name) {
    // Method to remove a step
    setState(() {
      _editableRecipe.steps.removeWhere((element) => element == name);
    });
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(recipeCategoriesProvider);
    final categoriesOptions = [
      RecipeCategory(id: '', name: 'Select a category', image: ''),
      ...categories
    ];
    return Scaffold(
        appBar: AppBar(
            title:
                Text(widget.recipe == null ? 'Create Recipe' : 'Edit Recipe')),
        body: Column(
          children: [
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 16.0),
                    child: ListView(
                        scrollDirection: Axis.vertical,
                        children: <Widget>[
                          TextFormField(
                            style: const TextStyle(fontSize: 28),
                            controller: _titleController,
                            decoration: const InputDecoration(
                              hintText: 'Title',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a title';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),
                          const Text('Category',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              )),
                          const SizedBox(height: 8),
                          DropdownButton<String>(
                            value: _editableRecipe.categoryId,
                            onChanged: (String? value) {
                              print('Selected category: $value');
                              setState(() {
                                _editableRecipe.categoryId = value!;
                              });
                            },
                            items: categoriesOptions
                                .map<DropdownMenuItem<String>>(
                                    (RecipeCategory category) {
                              return DropdownMenuItem<String>(
                                value: category.id,
                                child: Text(category.name),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 24),
                          // ingredients
                          const Text('Ingredients',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              )),
                          const SizedBox(height: 8),
                          Expanded(
                              child: Column(
                                  children: widget.recipe!.ingredients
                                      .asMap()
                                      .entries
                                      .map((entry) => IngredientRow(
                                          key: Key(entry.value.name +
                                              entry.key.toString()),
                                          ingredient: entry.value,
                                          onDelete: () {
                                            final name = _editableRecipe
                                                .ingredients[entry.key].name;
                                            _removeIngredient(name);
                                          },
                                          onChanged:
                                              (String key, String value) {
                                            _editableRecipe
                                                .ingredients[entry.key]
                                                .set(key, value);
                                          }))
                                      .toList())),
                          IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () => {
                                    setState(() {
                                      _editableRecipe.ingredients.add(
                                          Ingredient(name: '', quantity: ''));
                                    })
                                  }),
                          const SizedBox(height: 24),
                          const Text('Steps',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              )),
                          const SizedBox(height: 8),
                          Expanded(
                              child: Column(
                            children: [
                              ..._editableRecipe.steps
                                  .asMap()
                                  .entries
                                  .map((entry) => Row(
                                        key: Key(
                                            entry.value + entry.key.toString()),
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text((entry.key + 1).toString(),
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold)),
                                          const SizedBox(width: 8),
                                          Expanded(
                                              child: TextFormField(
                                                  initialValue: entry.value,
                                                  decoration:
                                                      const InputDecoration(
                                                    hintText:
                                                        'Step. e.g. Mix well',
                                                  ),
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Please enter the step';
                                                    }
                                                    return null;
                                                  },
                                                  onChanged: (String value) {
                                                    _editableRecipe
                                                            .steps[entry.key] =
                                                        value;
                                                  })),
                                          IconButton(
                                            icon: const Icon(
                                                Icons.delete_outline),
                                            onPressed: () {
                                              final step = _editableRecipe
                                                  .steps[entry.key];
                                              _removeStep(step);
                                            },
                                          )
                                        ],
                                      )),
                              IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () => {
                                        setState(() {
                                          _editableRecipe.steps.add('');
                                        })
                                      }),
                            ],
                          ))
                        ]))),
            MaterialButton(
                height: 74,
                minWidth: double.infinity,
                color: Theme.of(context).primaryColor,
                textColor: Colors.black,
                onPressed: () {
                  print(_editableRecipe);
                  if (_formKey.currentState!.validate()) {
                    print(_editableRecipe);
                    // Save the recipe
                    // If widget.recipe is null, create a new recipe
                    // Otherwise, update the existing recipe
                  }
                },
                child: const Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ))
          ],
        ));
  }
}

class IngredientRow extends StatelessWidget {
  Ingredient ingredient;
  Function onChanged;
  Function onDelete;

  IngredientRow(
      {super.key,
      required this.ingredient,
      required this.onChanged,
      required this.onDelete});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: TextFormField(
          initialValue: ingredient.name,
          onChanged: (value) {
            onChanged('name', value);
          },
          decoration: const InputDecoration(
            hintText: 'Name. e.g. Egg',
          ),
        )),
        Expanded(
            child: TextFormField(
          initialValue: ingredient.quantity,
          onChanged: (value) {
            onChanged('quantity', value);
          },
          decoration: const InputDecoration(
            hintText: 'Quantity. e.g. 2',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter the quantity';
            }
            return null;
          },
        )),
        IconButton(
          icon: const Icon(Icons.delete_outline),
          onPressed: () => onDelete(),
        )
      ],
    );
  }
}
