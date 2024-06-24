import 'package:Ricetta/models/receipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RecipeDetailScreen extends StatefulWidget {
  const RecipeDetailScreen({super.key});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  Recipe recipe = recipes[0];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
      Text(
        recipe.title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 28,
          fontFamily: 'SF Pro Display',
          fontWeight: FontWeight.w700,
          height: 0,
        ),
      ),
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
