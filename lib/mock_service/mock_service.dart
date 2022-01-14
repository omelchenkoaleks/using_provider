import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

// You import Chopper to create instances of Response.
import 'package:chopper/chopper.dart';
// show means that want a specific class or classes to be visible in app. In this case, want rootBundle to be visible for loading JSON files.
import 'package:flutter/services.dart' show rootBundle;
import '../network/model_response.dart';
import '../network/recipe_model.dart';

class MockService {
  // Use _currentRecipes1 and _currentRecipes2 to store the results loaded from the two JSON files.
  late APIRecipeQuery _currentRecipes1;
  late APIRecipeQuery _currentRecipes2;
  // nextRecipe is an instance of Random that creates a number between 0 and 1.
  Random nextRecipe = Random();

  // TODO: Add create and load methods

  // TODO: Add query method

}
