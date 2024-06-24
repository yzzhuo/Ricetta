import 'package:Ricetta/models/receipe.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FeatureRecipeWidget extends StatelessWidget {
  final Recipe recipe;
  const FeatureRecipeWidget({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          context.push('/recipe/1');
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
                        child: Image.network(
                          recipe.imageUrl,
                          fit: BoxFit.cover,
                        ))),
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
                        Text(recipe.title,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600)),
                        IconButton(
                            onPressed: () {
                              print('love');
                            },
                            icon: const Icon(Icons.favorite_border))
                      ]))
            ])));
  }
}
