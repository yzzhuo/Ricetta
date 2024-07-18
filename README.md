# Ricetta

## Description

*Ricetta* is a cross-platform responsive recipe application using Flutter and Firebase. Fearures include:
* For anyone using the application, the application allow viewing individual recipes, listing recipe categories, listing recipes in a given category, and searching recipes by name. 
* For authenticated users, the application allow creating and editing recipes, marking recipes as favorite, and listing favorite recipes.


## Key Challenges Faced

1. **Challenge 1**: [Describe a challenge you faced, such as implementing a specific feature or solving a particular problem in your application development process.]

2. **Challenge 2**: [Describe another challenge, possibly related to UI/UX, performance optimizations, or integrating with external APIs.]

3. **Challenge 3**: [Mention a third challenge, which could involve state management, database synchronization, or handling user inputs.]

## Key Learning Moments

1. **Learning Moment 1**: [Describe a significant learning moment in the project, such as understanding Flutter's widget lifecycle, state management solutions, etc.]

2. **Learning Moment 2**: [Mention another key learning, possibly related to effective debugging, UI design principles, or performance optimization techniques.]

3. **Learning Moment 3**: [Highlight a third learning moment, which could be about integrating with external services, Firebase, or learning a new Dart package.]

## Database Structure

The application uses Firebase as its backend. Here's an overview of the database structure:

- **Recipes**: Collection where each document represents a recipe.
  - `id`: String - Unique identifier for the recipe.
  - `title`: String - Name of the recipe.
  - `description`: String - Brief description of the recipe.
  - `ingredients`: Array - List of ingredients required.
  - `steps`: Array - Step-by-step instructions.
  - `category`: String - Category ID the recipe belongs to.

- **Categories**: Collection to categorize recipes.
  - `id`: String - Unique identifier for the category.
  - `name`: String - Name of the category.

- **Users**: Collection to store user information.
  - `uid`: String - Unique identifier for the user.
  - `email`: String - User's email address.
  - `favorites`: Array - List of recipe IDs marked as favorites by the user.

This structure is designed to be scalable and allows for easy querying of recipes, categories, and user-specific data.

## `pubspec.yaml` Contents
See `pubspec.yaml` in the root path of the project file.