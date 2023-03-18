import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:recipe_spoonacular_app/core/services/database_helper.dart';
import 'package:http/http.dart' as http;
import 'app.dart';
import 'bootstrap.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final dbHelper = DatabaseHelper();
  final httpClient = http.Client();
  final connectivity = Connectivity();
  bootstrap(
    () => RecipeApp(
      dbHelper: dbHelper,
      httpClient: httpClient,
      connectivity: connectivity,
    ),
  );
}
