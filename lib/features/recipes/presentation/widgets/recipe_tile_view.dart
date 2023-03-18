import 'package:flutter/material.dart';
import 'package:recipe_spoonacular_app/features/recipes/data/models/recipes.dart';

import '../../../../core/constants/style.dart';
import '../../../../core/widgets/simple_text.dart';

class RecipeListTile extends StatelessWidget {
  final Recipe recipe;
  const RecipeListTile({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: backgroundWhiteColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: strokeBrownColor,
          width: 0.5,
        ),
      ),
      child: Column(
        children: [
          if (recipe.imageUrl != null) ...[
            Container(
              height: 140,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: Image.network(recipe.imageUrl!).image,
                ),
              ),
            )
          ],
          if (recipe.imageUrl == null) ...[
            Container(
              height: 140,
              alignment: Alignment.center,
              child: const SimpleText(
                'No image available for this recipe',
              ),
            )
          ],
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SimpleText(
                      recipe.title,
                      size: 16,
                      color: const Color(0xFF141516),
                      weight: FontWeight.w300,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
