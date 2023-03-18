class ApiConstants {
  static const apiKey = '63c3ca01e28140e4baac73f4f0b5acf3';
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
