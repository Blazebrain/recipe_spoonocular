import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/services/database_helper.dart';
import 'features/recipes/data/repositories/recipe_repository.dart';
import 'features/recipes/presentation/bloc/recipes_bloc.dart';
import 'package:http/http.dart' as http;

import 'features/recipes/presentation/ui/recipe_page.dart';

class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => RecipeBloc(
          recipeRepository: RecipeRepository(
            httpClient: http.Client(),
            dbHelper: DatabaseHelper(),
          ),
        ),
        child: const RecipePage(),
      ),
    );
  }
}
