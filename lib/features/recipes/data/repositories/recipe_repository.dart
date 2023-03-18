import '../../../../core/services/database_helper.dart';
import '../models/recipes.dart';
import 'package:http/http.dart' as http;

class RecipeRepository {
  final http.Client httpClient;
  final DatabaseHelper dbHelper;

  RecipeRepository({required this.httpClient, required this.dbHelper});

  // Future<List<Recipe>> getRandomRecipes(int page) async {
  //   // Fetch random recipes from spoonacular API and store them in the local database

  // }

  // Future<List<Recipe>> searchRecipes(String query) async {
  //   // Search recipes from spoonacular API and store them in the local database
  // }

  // Future<List<Recipe>> getLocalRecipes() async {
  //   // Load recipes from the local database
  // }
}
