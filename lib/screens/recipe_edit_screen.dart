import 'package:Ricetta/models/category.dart';
import 'package:Ricetta/models/recipe.dart';
import 'package:Ricetta/providers/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecipeEditScreen extends ConsumerStatefulWidget {
  final Recipe? recipe; // Assuming there's a Recipe model
  const RecipeEditScreen({super.key, this.recipe});

  @override
  _RecipeEditScreenState createState() => _RecipeEditScreenState();
}

class _RecipeEditScreenState extends ConsumerState<RecipeEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  final TextEditingController _categoryController = TextEditingController();

  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.recipe?.title ?? '');
    _descriptionController =
        TextEditingController(text: widget.recipe?.title ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
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
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Expanded(
                                      child: TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Name. e.g. Egg',
                                    ),
                                  )),
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
                          )),
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
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),
                ))
          ],
        ));
  }
}
