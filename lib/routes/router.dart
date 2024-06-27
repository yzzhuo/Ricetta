import 'package:go_router/go_router.dart';
import '../widgets/layout.dart';
import '../screens/home_screen.dart';
import 'package:Ricetta/screens/profile_screen.dart';
import '../screens/recipe_detail_screen.dart';
import '../screens/recipe_category_screen.dart';
import '../screens/recipe_list_screen.dart';
import '../screens/signup_screen.dart';
import '../screens/setting_screen.dart';
import 'package:Ricetta/screens/recipe_edit_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
        path: '/',
        builder: (context, state) => Layout(child: const HomeScreen())),
    GoRoute(
        path: '/recipe/edit',
        builder: (context, state) => const RecipeEditScreen()),
    GoRoute(
        path: '/recipe/:recipeId',
        builder: (context, state) => Layout(
            child: RecipeDetailScreen(
                recipeId: state.pathParameters['recipeId'] ?? ''))),
    GoRoute(
      path: '/category',
      builder: (context, state) => Layout(
        child: const RecipeCategoryScreen(),
      ),
    ),
    GoRoute(
        path: '/recipes',
        builder: (context, state) {
          final categoryId = state.uri.queryParameters['categoryId'] ?? '';
          final searchName = state.uri.queryParameters['search'] ?? '';

          return Layout(
              child: RecipeCategoryDetailScreen(
            categoryId: categoryId,
            searchName: searchName,
          ));
        }),
    GoRoute(
        path: '/profile', builder: (context, state) => const ProfileScreen()),
    GoRoute(path: '/signup', builder: (context, state) => const SignupScreen()),
    GoRoute(
        path: '/settings', builder: (context, state) => const SettingScreen()),
  ],
);
