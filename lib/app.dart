import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/services/database_helper.dart';
import 'features/recipes/data/repositories/recipe_repository.dart';
import 'features/recipes/presentation/bloc/recipes_bloc.dart';
import 'package:http/http.dart' as http;

import 'features/recipes/presentation/ui/recipe_page.dart';

class RecipeApp extends StatelessWidget {
  final DatabaseHelper dbHelper;
  final Connectivity connectivity;
  final http.Client httpClient;
  const RecipeApp({
    super.key,
    required this.dbHelper,
    required this.connectivity,
    required this.httpClient,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => RecipeBloc(
          recipeRepository: RecipeRepository(
            httpClient: httpClient,
            dbHelper: dbHelper,
            connectivity: connectivity,
          ),
        ),
        child: const RecipePage(),
      ),
    );
  }
}
