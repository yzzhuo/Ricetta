import 'package:Ricetta/models/recipe.dart';
import 'package:Ricetta/providers/recipe_provider.dart';
import 'package:Ricetta/utils/breakpoint.dart';
import 'package:Ricetta/widgets/feature_recipe_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:Ricetta/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/screens/login_screen.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return Scaffold(
        body:
            user == null ? const LoginScreen() : const PorfileContentScreen());
  }
}

class PorfileContentScreen extends ConsumerStatefulWidget {
  const PorfileContentScreen({super.key});

  @override
  _PorfileContentScreen createState() => _PorfileContentScreen();
}

class _PorfileContentScreen extends ConsumerState<PorfileContentScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  int _selectedIndex = 0; // 默认选中第一个Tab

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // 更新选中的Tab索引
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final recipeState = ref.watch(recipesProvider);
    final recipes = recipeState.recipes;
    final favouriteRecipes =
        recipes.where((recipe) => recipe.isFavourite).toList();
    final myRecipes =
        recipes.where((recipe) => recipe.userId == user!.uid).toList();

    return Scaffold(
        appBar: AppBar(
            title: const Text('Profile',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                )),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                context.pop();
              },
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () async {
                  context.push('/settings');
                },
              )
            ]),
        floatingActionButton: _selectedIndex == 1
            ? FloatingActionButton(
                onPressed: () {
                  context.push('/edit/recipe');
                },
                foregroundColor: Colors.black,
                backgroundColor: Theme.of(context).primaryColor,
                shape: const CircleBorder(),
                child: const Icon(Icons.add),
              )
            : null,
        body: Container(
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              TabBar(
                controller: _tabController,
                onTap: _onItemTapped,
                tabs: const <Widget>[
                  Tab(
                    text: 'Favourites',
                  ),
                  Tab(
                    text: 'My Recipes',
                  ),
                ],
              ),
              Expanded(
                  child: TabBarView(controller: _tabController, children: [
                favouriteRecipes.isEmpty
                    ? const Center(
                        child:
                            Text("You don't have any favourites recipes yet."))
                    : buildRecipeList(
                        recipes: favouriteRecipes, context: context),
                myRecipes.isEmpty
                    ? const Center(
                        child: Text("You don't have any recipes yet."))
                    : buildRecipeList(
                        recipes: myRecipes,
                        context: context,
                        onEdit: (String recipeId) {
                          context.push('/edit/recipe?id=$recipeId');
                        },
                        onDelete: (recipeId) async {
                          ref
                              .read(recipesProvider.notifier)
                              .deleteRecipe(recipeId);
                        }),
              ]))
            ])));
  }
}

// Method to build the recipe list view
Widget buildRecipeList(
    {required List<Recipe> recipes,
    required BuildContext context,
    Function? onDelete,
    Function? onEdit}) {
  return GridView.builder(
    padding: const EdgeInsets.only(top: 20),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount:
          MediaQuery.of(context).size.width > Breakpoints.md ? 3 : 1,
      childAspectRatio: 3 / 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
    ),
    itemCount: recipes.length,
    itemBuilder: (context, index) {
      final recipe = recipes[index];
      return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: FeatureRecipeWidget(
              recipe: recipe,
              onEdit: onEdit != null
                  ? () {
                      onEdit(recipe.id);
                    }
                  : null,
              onDelete: onDelete != null
                  ? () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Delete Recipe'),
                            content: const Text(
                                'Are you sure you want to delete this recipe?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  try {
                                    await onDelete(recipe.id);
                                    // close the dialog
                                    Navigator.of(context).pop();
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('Failed to delete recipe')),
                                    );
                                  }
                                },
                                child: const Text('Delete'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  : null));
    },
  );
}
