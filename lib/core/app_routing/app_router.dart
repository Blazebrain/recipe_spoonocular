import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe_spoonacular_app/features/recipes/presentation/ui/recipe_page.dart';
import '../../features/recipes/presentation/ui/welcome_page.dart';
import 'route_names.dart';

class AppRouter {
  ///Build a MaterialPageRoute with the provided [page] widget and return it.
  static Route _materialPageRoute(Widget page) =>
      MaterialPageRoute(builder: (_) => page);

  ///Build a CupetinoPageRoute with the provided [page] widget and return it.
  static Route _cupertinoPageRoute(Widget page) =>
      CupertinoPageRoute(builder: (_) => page);

  ///Check route name and return corresponding Route.
  ///Used for `OnGenerateRoute` in *main.dart*
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case welcomeViewRoute:
        return _cupertinoPageRoute(const WelcomeView());

      case recipesViewRoute:
        return _cupertinoPageRoute(const RecipePage());

      //* Bad route - Route not found page
      default:
        return _materialPageRoute(
          Scaffold(
            body: Center(
              child: Text(
                'Error 404.'
                'The route - ${settings.name} - you requested does not exist',
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
        );
    }
  }
}
