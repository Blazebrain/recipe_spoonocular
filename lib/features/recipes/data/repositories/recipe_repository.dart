import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_spoonacular_app/core/constants/api_constants.dart';

import '../../../../core/services/database_helper.dart';
import '../models/recipes.dart';

class RecipeRepository {
  final http.Client httpClient;
  final DatabaseHelper dbHelper;
  final Connectivity connectivity;

  RecipeRepository(
      {required this.httpClient,
      required this.dbHelper,
      required this.connectivity});

  Future<List<Recipe>> getRandomRecipes() async {
    final connectivityResult = await connectivity.checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      final recipes = await getLocalRecipes();
      return recipes;
    } else {
      final response = await httpClient.get(ApiConstants.getRandomRecipe());
      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        final recipes = (data['recipes'] as List)
            .map((recipeJson) => Recipe.fromJson(recipeJson))
            .toList();

        await dbHelper.insertRecipes(recipes);
        return recipes;
      } else {
        throw Exception(data['message']);
      }
    }
  }

  Future<List<Recipe>> searchRecipes(String query) async {
    final response = await httpClient.get(ApiConstants.searchRecipes(query));
    final data = json.decode(response.body);
    if (response.statusCode == 200) {
      final recipes = (data['results'] as List)
          .map((recipeJson) => Recipe.fromJson(recipeJson))
          .toList();

      await dbHelper.insertRecipes(recipes);
      return recipes;
    } else {
      throw Exception(data['message']);
    }
  }

  Future<List<Recipe>> getLocalRecipes() async {
    return await dbHelper.getRecipes();
  }
}
