import 'package:go_router/go_router.dart';
import '../widgets/layout.dart';
import '../screens/home_screen.dart';
import '../screens/recipe_detail_screen.dart';
import '../screens/recipe_category_screen.dart';
import '../screens/recipe_category_detail_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
        path: '/',
        builder: (context, state) => Layout(child: const HomeScreen())),
    GoRoute(
        path: '/recipe/:receipeId',
        builder: (context, state) => Layout(
              child: const RecipeDetailScreen(),
            )),
    GoRoute(
      path: '/category',
      builder: (context, state) => Layout(
        child: const RecipeCategoryScreen(),
      ),
    ),
    GoRoute(
      path: '/category/:categoryId',
      builder: (context, state) => Layout(
        child: const RecipeCategoryDetailScreen(),
      ),
    )
  ],
);