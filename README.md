# Ricetta
*Ricetta* is a cross-platform responsive recipe application using Flutter and Firebase. Fearures include:
* For anyone using the application, the application allow viewing individual recipes, listing recipe categories, listing recipes in a given category, and searching recipes by name. 
* For authenticated users, the application allow creating and editing recipes, marking recipes as favorite, and listing favorite recipes.

## Key Challenges Faced

1. **Challenge 1: Nested Route**: Implementing nested routes was a significant challenge. The application's architecture required a sophisticated navigation model to manage deep linking and state restoration across multiple levels of nested screens, which was crucial for a seamless user experience.
2. **Challenge 2: Error Capture**: Capturing and handling errors gracefully, especially those from external API calls, was another hurdle. Ensuring the UI remains informative and non-disruptive when errors occur required implementing robust error handling and user feedback mechanisms.
3. **Challenge 3: State Management**: Managing the application's state, particularly synchronizing the user's favorites and settings across devices, presented complexities. The challenge was to ensure a reactive and consistent state across the application without causing performance bottlenecks or user data inconsistencies.

## Key Learning Moments
1. **Learning Moment 1**: Delving into Flutter's widget lifecycle and exploring various state management solutions was enlightening. Understanding the nuances of how widgets rebuild and maintain state helped in optimizing the app's performance and responsiveness.
2. **Learning Moment 2**: The exploration of state management solutions in Flutter, such as Provider, Riverpod, was a crucial learning curve. It provided insights into managing complex application states in a scalable and maintainable way.
3. **Learning Moment 3**: Integrating external services like Firebase into the Flutter application was a valuable experience. It not only facilitated features like authentication and data storage but also offered lessons in handling real-time data synchronization and leveraging cloud functions for scalable backend logic.

## Database Structure

The application uses Firebase as its backend. Here's an overview of the database structure:
- **recipes**: Collection where each document represents a recipe.
  - `id`: String - Unique identifier for the recipe.
  - `title`: String - Name of the recipe.
  - `categoryId`: String - Category ID the recipe belongs to.
  - `imageUrl`: String - Image URL for the recipe.
  - `ingredients`: Array<Map> - List of ingredients required.
      - `name`: String - name for ingredient.
      - `quantity`: String - quantity for ingredient.
  - `steps`: Array<String> - Step-by-step instructions.
  - `userId`: String - owner of the recipe. It is created by administrator when userId is empty.
- **categories**: Collection to categorize recipes.
  - `id`: String - Unique identifier for the category.
  - `name`: String - Name of the category.
  - `image`: String - imageUrl for the category.

- **favourite_recipes**: Collection to store user information.
  - `uid`: String - Unique identifier for the user.
  - `recipeId`: String - RecipeId of the favourite recipe.

## Feature Checklist
* [x]  Generic application structure of all pages:
  * [x] A top bar (AppBar) that provides a searchbar for recipes based on their name. Searching for recipes shows a recipe list page with recipes whose name match the searched name.
  * [x] Contents for each specific page are shown in the main body of the application.
  * [x] Bottom bar (BottomNavigationBar) that could provide a link to the main page of the application and other main screens
* [x]  Main page
  * [x] Shows a featured recipe, a subset of recipe categories, and a link to the category page.
  * [x] Selecting the featured recipe opens the recipe in the recipe page.
  * [x] Selecting a recipe category opens up a recipe list page that lists recipes in the selected category.
  * [x] Selecting the link to the category page opens up a recipe category page that lists recipe categories.
* [x]  Recipe page
  * [x] Shows the details of the selected a recipe, including the recipe name, a picture of the recipe, the recipe ingredients, and the recipe steps, retrieved from a backend.
* [x]  Recipe category page
  * [x] The recipe category page lists the recipe categories.
  * [x] Each recipe category should have a name and a picture. The recipe categories are retrieved from a backend.
  * [x] Clicking on a recipe category opens up the recipe list page that lists recipes in the selected category.
* [x] Recipe list page
  * [x] The recipe list page shows a list of recipes for a selected category.
  * [x] The list of recipes are retrieved from a backend.
* [x] Application responsiveness
  * [x] The application has at least two sensible breakpoints that change how the contents of the application are shown to the user(mobile and desktop devices).
  * [x] The way how the recipes and categories are shown depends on the layout; in a wider option, the application can e.g. show both a list of categories and a list of recipes for a selected category on the same page (allowing scrolling of recipes within a category while still being able to smoothly change category).
  * [x] For contents that do not fit the screen, whenever meaningful, use e.g. ListView or GridView
* [x] Navigation between the different pages
* [x] The application supports logging in and logging out from the application.
  * [x] All users, regardless of whether they have been logged in or not, can view recipes, search for recipes, explore the recipe categories, and view lists of recipes
Include the functionality for logging in / logging out into the application bar.
  * [x] Implement logging in using anonymous authentication (i.e. the user does not have to type in their email address or password);and authentication types that login with email and password.
* [x] The application supports creating recipes for authenticated users.
  * [x] When creating a recipe, the user types in the recipe details, which include the recipe name, the recipe ingredients, and the recipe steps.
  * [x]  when creating a recipe, the user can select the categories to which the recipe belongs.
  * [x] The form data is validated -- the user cannot submit the form if the recipe name is empty or if the recipe does not have any ingredients or steps.
  * [x] Created recipes are stored in the database and can be viewed by all users.
* [x] The application supports deleting and editing recipes.
  * [x] Users can delete their own recipes.
  * [x] Users can edit their own recipes.
* [x] The application supports marking recipes as favorite.
  * [x] Users can mark recipes as favorite both in the recipe list page and in the recipe page. Information on the favorite recipes is stored in the database.
  * [x] Users can access a page that shows their favorite recipes.
  * [x] The recipe page and the list of recipes shows the number of times the recipe has been marked as favorite (over all users).
* [ ] The recipe list page and the category page use smooth scrolling:At first, up to 20 items are shown, and when the page is scrolled, additional data is retrieved.

## `pubspec.yaml` Contents
See `pubspec.yaml` in the root path of the project file.
