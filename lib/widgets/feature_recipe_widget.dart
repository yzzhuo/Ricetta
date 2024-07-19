import 'package:Ricetta/providers/recipe_provider.dart';
import 'package:Ricetta/providers/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Ricetta/models/recipe.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FeatureRecipeWidget extends ConsumerWidget {
  final Recipe recipe;
  final Function? onEdit;
  final Function? onDelete;
  const FeatureRecipeWidget(
      {super.key, required this.recipe, this.onEdit, this.onDelete});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    handleFavourte() async {
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please login to add to favourite')),
        );
      } else {
        try {
          await ref
              .read(recipesProvider.notifier)
              .addFavoriteRecipe(recipe.id!, user.uid, !recipe.isFavourite);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Added to favourites successfully!')),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to add to favourite')),
          );
        }
      }
    }

    return GestureDetector(
        onTap: () {
          context.push('/recipe/${recipe.id}');
        },
        child: Container(
            height: 204,
            margin: const EdgeInsets.only(right: 16.0),
            width: MediaQuery.of(context).size.width - 32,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromARGB(43, 193, 192, 192),
                      blurRadius: 30,
                      offset: Offset(0, 4))
                ]),
            child: Column(children: [
              Expanded(
                  child: SizedBox(
                width: double.infinity,
                child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0)),
                    child: AspectRatio(
                        aspectRatio: 315 / 204,
                        child: recipe.imageUrl.isNotEmpty
                            ? Image.network(
                                recipe.imageUrl,
                                fit: BoxFit.cover,
                              )
                            : const Placeholder())),
              )),
              Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(16.0),
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(43, 193, 192, 192),
                        blurRadius: 30,
                        offset: Offset(0, 4),
                      )
                    ],
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Text(recipe.title,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600))),
                        onEdit != null
                            ? IconButton(
                                onPressed: () {
                                  onEdit!();
                                },
                                icon: const Icon(Icons.edit))
                            : onDelete != null
                                ? IconButton(
                                    onPressed: () {
                                      onDelete!();
                                    },
                                    icon: const Icon(Icons.delete))
                                : const SizedBox(),
                        onDelete != null
                            ? IconButton(
                                onPressed: () {
                                  onDelete!();
                                },
                                icon: const Icon(Icons.delete))
                            : const SizedBox(),
                        IconButton(
                            onPressed: handleFavourte,
                            icon: recipe.isFavourite
                                ? const Icon(Icons.favorite)
                                : const Icon(Icons.favorite_border))
                      ]))
            ])));
  }
}
