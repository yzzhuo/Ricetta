import 'package:Ricetta/models/recipe.dart';
import 'package:Ricetta/providers/recipe_provider.dart';
import 'package:Ricetta/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecipeDetailScreen extends ConsumerStatefulWidget {
  final String recipeId;
  const RecipeDetailScreen({super.key, required this.recipeId});

  @override
  _RecipeDetailScreenState createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends ConsumerState<RecipeDetailScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Trigger fetching the question when the widget is first built
      ref.read(recipesProvider.notifier).getRecipeDetailById(widget.recipeId);
    });
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recipeState = ref.watch(recipesProvider);
    final recipe = recipeState.recipe;
    final user = ref.watch(userProvider);

    handleFavourte() async {
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please login to add to favourite')),
        );
      } else {
        try {
          if (recipe == null) return;
          await ref
              .read(recipesProvider.notifier)
              .addFavoriteRecipe(recipe.id!, user.uid, !recipe.isFavourite);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Added to favourites successfully!')),
          );
          ref.read(recipesProvider.notifier).getRecipeDetailById(recipe.id!);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to add to favourite')),
          );
        }
      }
    }

    if (recipe == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return Column(children: [
      SizedBox(
        height: 226,
        child: Image.network(
          recipe.imageUrl,
          width: double.infinity,
          height: 300,
          fit: BoxFit.cover,
        ),
      ),
      const SizedBox(height: 26.0),
      Row(children: [
        Expanded(
            child: Center(
                child: Text(
          recipe.title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontFamily: 'SF Pro Display',
            fontWeight: FontWeight.w700,
            height: 0,
          ),
        ))),
        Row(children: [
          IconButton(
              onPressed: handleFavourte,
              icon: recipe.isFavourite
                  ? const Icon(Icons.favorite)
                  : const Icon(Icons.favorite_border)),
          recipe.favouriteTotal != 0
              ? Text(recipe.favouriteTotal.toString(),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400))
              : const SizedBox()
        ])
      ]),
      const SizedBox(height: 12.0),
      TabBar(
        controller: _tabController,
        tabs: const <Widget>[
          Tab(
            text: 'Ingredients',
          ),
          Tab(
            text: 'Steps',
          ),
        ],
      ),
      Expanded(
          child: TabBarView(
        controller: _tabController,
        children: [
          Center(
            child: ListView(
                children: recipe.ingredients
                    .map((ingredient) => IngredientItem(ingredient: ingredient))
                    .toList()),
          ),
          ListView(
            children: recipe.steps.asMap().entries.map((entry) {
              int index = entry.key;
              String step = entry.value;
              return ListTile(
                title: Row(children: [
                  Container(
                    width: 28,
                    height: 28,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFFFD60A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            (index + 1).toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              height: 0.10,
                            ),
                          ),
                        ]),
                  ),
                  Expanded(
                      child: Text(
                    step,
                    softWrap: true,
                  ))
                ]),
              );
            }).toList(),
          ),
        ],
      ))
    ]);
  }
}

class IngredientItem extends StatelessWidget {
  final Ingredient ingredient;
  const IngredientItem({required this.ingredient, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 322,
        height: 22,
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.black38),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              ingredient.name,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'SF Pro Text',
                fontWeight: FontWeight.w400,
                height: 0.09,
              ),
            ),
            const SizedBox(width: 135),
            Text(
              ingredient.quantity,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'SF Pro Text',
                fontWeight: FontWeight.w400,
                height: 0.09,
              ),
            ),
          ],
        ));
  }
}
