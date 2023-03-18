import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/recipes.dart';

import '../../data/repositories/recipe_repository.dart';
part 'recipes_event.dart';
part 'recipes_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final RecipeRepository recipeRepository;
  final Connectivity connectivity;
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;

  RecipeBloc({
    required this.connectivity,
    required this.recipeRepository,
  }) : super(RecipeInitial()) {
    _connectivitySubscription =
        connectivity.onConnectivityChanged.listen((result) {
      if (result != ConnectivityResult.none) {
        add(LoadRandomRecipes(page: 1));
      }
    });

    on<LoadRandomRecipes>(_loadRandomRecipes);
    on<SearchRecipes>(_searchRecipes);
  }

  void _loadRandomRecipes(
      LoadRandomRecipes event, Emitter<RecipeState> emit) async {
    emit(RecipeLoading());
    try {
      List<Recipe> recipes;
      recipes = await recipeRepository.getRandomRecipes(event.page);
      emit(RecipeLoaded(recipes: recipes));
    } catch (e) {
      emit(RecipeError(
        message: e.toString(),
        onRetry: () {
          add(event);
        },
      ));
    }
  }

  void _searchRecipes(SearchRecipes event, Emitter<RecipeState> emit) async {
    emit(RecipeLoading());
    try {
      List<Recipe> recipes;
      recipes = await recipeRepository.searchRecipes(event.query);
      emit(RecipeLoaded(recipes: recipes));
    } catch (e) {
      emit(
        RecipeError(
          message: e.toString(),
          onRetry: () {
            add(event);
          },
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    return super.close();
  }
}
