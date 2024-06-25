import 'package:Ricetta/widgets/category_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/providers/category_provider.dart';

class RecipeCategoryScreen extends ConsumerWidget {
  const RecipeCategoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(recipeCategoriesProvider);

    return Column(children: [
      const SizedBox(height: 24.0),
      Container(
        alignment: Alignment.centerLeft,
        child: const Text('Category',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              height: 0,
            )),
      ),
      const SizedBox(height: 24.0),
      Expanded(
          child: ListView(
        scrollDirection: Axis.vertical,
        children: categories
            .map((category) => Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: CategoryCard(category: category)))
            .toList(),
      )),
    ]);
  }
}
