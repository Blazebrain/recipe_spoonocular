// bloc/recipe_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/recipes.dart';

import '../../data/repositories/recipe_repository.dart';
part 'recipes_event.dart';
part 'recipes_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final RecipeRepository recipeRepository;

  RecipeBloc({required this.recipeRepository}) : super(RecipeInitial()) {
    on<LoadRandomRecipes>(_loadRandomRecipes);
    on<SearchRecipes>(_searchRecipes);
  }

  void _loadRandomRecipes(
      LoadRandomRecipes event, Emitter<RecipeState> emit) async {
    // Handle loading random recipes
  }

  void _searchRecipes(SearchRecipes event, Emitter<RecipeState> emit) async {
    // Handle searching recipes
  }
}
