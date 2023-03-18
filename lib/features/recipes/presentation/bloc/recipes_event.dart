part of 'recipes_bloc.dart';

abstract class RecipeEvent {}

class LoadRandomRecipes extends RecipeEvent {
  LoadRandomRecipes();
}

class SearchRecipes extends RecipeEvent {
  final String query;
  SearchRecipes({required this.query});
}
