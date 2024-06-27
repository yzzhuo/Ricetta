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
  late TextEditingController _categoryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _editableRecipe = widget.recipe!;
    _titleController = TextEditingController(text: widget.recipe?.title ?? '');
    _categoryController =
        TextEditingController(text: widget.recipe?.categoryId ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  void _removeIngredient(String name) {
    print(_editableRecipe.ingredients);
    // Method to remove an ingredient
    setState(() {
      _editableRecipe.ingredients
          .removeWhere((element) => element.name == name);
    });
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(recipeCategoriesProvider);
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
                          DropdownMenu(
                            width: MediaQuery.of(context).size.width * 0.9,
                            controller: _categoryController,
                            dropdownMenuEntries: categories
                                .map<DropdownMenuEntry<dynamic>>(
                                    (RecipeCategory category) =>
                                        DropdownMenuEntry<dynamic>(
                                          value: category.id,
                                          label: category.name,
                                        ))
                                .toList(),
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('1',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(width: 8),
                                  Expanded(
                                      child: TextFormField(
                                    decoration: const InputDecoration(
                                      hintText: 'Quantity. e.g. 2',
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the quantity';
                                      }
                                      return null;
                                    },
                                  ))
                                ],
                              ),
                            ],
                          ))
                        ]))),
            MaterialButton(
                height: 74,
                minWidth: double.infinity,
                color: Theme.of(context).primaryColor,
                textColor: Colors.black,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Save the recipe
                    // If widget.recipe is null, create a new recipe
                    // Otherwise, update the existing recipe
                    Navigator.pop(context);
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
