import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:recipe_spoonacular_app/core/constants/api_constants.dart';

import '../../../../core/services/database_helper.dart';
import '../models/recipes.dart';

class RecipeRepository {
  final http.Client httpClient;
  final DatabaseHelper dbHelper;

  RecipeRepository({required this.httpClient, required this.dbHelper});

  Future<List<Recipe>> getRandomRecipes(int page) async {
    final response = await httpClient.get(ApiConstants.getRandomRecipe());
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final recipes = (data['recipes'] as List)
          .map((recipeJson) => Recipe.fromJson(recipeJson))
          .toList();

      await dbHelper.insertRecipes(recipes);
      return recipes;
    } else {
      throw Exception('Failed to load random recipes');
    }
  }

  Future<List<Recipe>> searchRecipes(String query) async {
    final response = await httpClient.get(ApiConstants.searchRecipes(query));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final recipes = (data['results'] as List)
          .map((recipeJson) => Recipe.fromJson(recipeJson))
          .toList();

      await dbHelper.insertRecipes(recipes);
      return recipes;
    } else {
      throw Exception('Failed to search recipes');
    }
  }

  Future<List<Recipe>> getLocalRecipes() async {
    return await dbHelper.getRecipes();
  }
}
