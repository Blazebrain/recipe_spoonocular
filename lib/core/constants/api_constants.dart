class ApiConstants {
  static Uri getRandomRecipe() {
    return Uri.parse(
      'https://api.spoonacular.com/recipes/random?apiKey=YOUR_API_KEY&number=10',
    );
  }

  static Uri searchRecipes(String query) {
    return Uri.parse(
        'https://api.spoonacular.com/recipes/complexSearch?apiKey=YOUR_API_KEY&query=$query');
  }
}
