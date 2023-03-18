import 'package:flutter/material.dart';

import '../../data/models/recipes.dart';

class RecipeDetailsPage extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailsPage({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (recipe.imageUrl != null) ...[
              Image.network(recipe.imageUrl!),
            ],
            if (recipe.imageUrl == null) ...[
              const Text(
                'No image available for this recipe',
                style: TextStyle(fontSize: 16),
              ),
            ],
            const SizedBox(height: 16),
            Text(
              recipe.title,
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
