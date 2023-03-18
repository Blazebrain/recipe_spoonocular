import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_spoonacular_app/core/app_routing/app_navigator.dart';
import 'package:recipe_spoonacular_app/core/app_routing/app_router.dart';

import 'core/services/database_helper.dart';
import 'features/recipes/data/repositories/recipe_repository.dart';
import 'features/recipes/presentation/bloc/recipes_bloc.dart';
import 'package:http/http.dart' as http;

class RecipeApp extends StatelessWidget {
  RecipeApp({super.key});

  final dbHelper = DatabaseHelper();
  final httpClient = http.Client();
  final connectivity = Connectivity();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => RecipeRepository(
        httpClient: httpClient,
        dbHelper: dbHelper,
        connectivity: connectivity,
      ),
      child: BlocProvider(
        create: (context) => RecipeBloc(
          connectivity: connectivity,
          recipeRepository: context.read(),
        ),
        child: MaterialApp(
          title: 'Recipes App',
          navigatorKey: AppNavigator.key,
          onGenerateRoute: AppRouter.generateRoute,
        ),
      ),
    );
  }
}
