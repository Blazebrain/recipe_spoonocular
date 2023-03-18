class ApiConstants {
  static const apiKey = 'aa4899614e974597a63d7434aa2365e9';
  static Uri getRandomRecipe(page) {
    return Uri.parse(
      'https://api.spoonacular.com/recipes/random?apiKey=$apiKey&number=10',
    );
  }

  static Uri searchRecipes(String query) {
    return Uri.parse(
        'https://api.spoonacular.com/recipes/complexSearch?apiKey=$apiKey&query=$query');
  }
}
