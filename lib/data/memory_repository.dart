import 'dart:core';
import 'package:flutter/foundation.dart';
// repository.dart contains the interface definition.
import 'repository.dart';
// models.dart exports the Recipe and Ingredient class definitions.
import 'models/models.dart';

// MemoryRepository extends Repository and uses Flutter’s ChangeNotifier to enable listeners and notify those listeners of any changes.
class MemoryRepository extends Repository with ChangeNotifier {
  //  Initialize current list of recipes.
  final List<Recipe> _currentRecipes = <Recipe>[];
  // Initialize current list of ingredients.
  final List<Ingredient> _currentIngredients = <Ingredient>[];

  // ----- Finding stored recipes and ingredients:

  @override
  List<Recipe> findAllRecipes() {
    // Returns current RecipeList.
    return _currentRecipes;
  }

  @override
  Recipe findRecipeById(int id) {
    // Uses firstWhere to find a recipe with the given ID.
    return _currentRecipes.firstWhere((recipe) => recipe.id == id);
  }

  @override
  List<Ingredient> findAllIngredients() {
    // Returns your current ingredient list.
    return _currentIngredients;
  }

  @override
  List<Ingredient> findRecipeIngredients(int recipeId) {
    // Finds a recipe with the given ID.
    final recipe =
        _currentRecipes.firstWhere((recipe) => recipe.id == recipeId);
    // Uses where to find all the ingredients with the given recipe ID.
    final recipeIngredients = _currentIngredients
        .where((ingredient) => ingredient.recipeId == recipe.id)
        .toList();
    return recipeIngredients;
  }

  // ----- Adding recipes and ingredient lists:

  @override
  int insertRecipe(Recipe recipe) {
    // Add the recipe to list.
    _currentRecipes.add(recipe);
    // Call the method to add all the recipe’s ingredients.
    if (recipe.ingredients != null) {
      insertIngredients(recipe.ingredients!);
    }
    // Notify all listeners of the changes.
    notifyListeners();
    // Return the ID of the new recipe. Since don’t need it, it’ll always return 0.
    return 0;
  }

  @override
  List<int> insertIngredients(List<Ingredient> ingredients) {
    // Check to make sure there are some ingredients.
    if (ingredients.length != 0) {
      // Add all the ingredients tolist.
      _currentIngredients.addAll(ingredients);
      // Notify all listeners of the changes.
      notifyListeners();
    }
    // Return the list of IDs added. An empty list for now.
    return <int>[];
  }

  // ----- Deleting recipes and ingredients:

  @override
  void deleteRecipe(Recipe recipe) {
    // Remove the recipe from your list.
    _currentRecipes.remove(recipe);
    // Delete all the ingredients for this recipe.
    if (recipe.id != null) {
      deleteRecipeIngredients(recipe.id!);
    }
    // Notify all listeners that the data has changed.
    notifyListeners();
  }

  @override
  void deleteIngredient(Ingredient ingredient) {
    // Remove the ingredients from list.
    _currentIngredients.remove(ingredient);
  }

  @override
  void deleteIngredients(List<Ingredient> ingredients) {
    // Remove all ingredients that are in the passed-in list.
    _currentIngredients
        .removeWhere((ingredient) => ingredients.contains(ingredient));
    notifyListeners();
  }

  @override
  void deleteRecipeIngredients(int recipeId) {
    // Go through all ingredients and look for ingredients that have the given recipe ID, then remove them.
    _currentIngredients
        .removeWhere((ingredient) => ingredient.recipeId == recipeId);
    notifyListeners();
  }

  // Since this is a memory repository, don’t need to do anything to initialize and close but need to implement these methods.
  @override
  Future init() {
    return Future.value(null);
  }

  @override
  void close() {}
}
