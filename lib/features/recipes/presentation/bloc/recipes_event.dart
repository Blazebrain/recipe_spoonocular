abstract class RecipeEvent {}

class LoadRandomRecipes extends RecipeEvent {
  final int page;
  LoadRandomRecipes({required this.page});
}

class SearchRecipes extends RecipeEvent {
  final String query;
  SearchRecipes({required this.query});
}
