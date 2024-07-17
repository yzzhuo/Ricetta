import 'package:Ricetta/utils/breakpoint.dart';
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
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    MediaQuery.of(context).size.width > Breakpoints.md
                        ? 2
                        : 1, // 3 columns for wide screens, 2 for narrow ones
                childAspectRatio: 6, // Adjust the size ratio of the grid items
                crossAxisSpacing: 10, // Space between items horizontally
                mainAxisSpacing: 10, // Space between items vertically
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return CategoryCard(category: categories[index]);
              }))
    ]);
  }
}
