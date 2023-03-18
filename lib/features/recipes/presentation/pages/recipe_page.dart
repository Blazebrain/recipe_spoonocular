import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_spoonacular_app/core/constants/style.dart';

import '../../../../core/widgets/custom_dot_widget.dart';
import '../../../../core/widgets/simple_text.dart';
import '../bloc/recipes_bloc.dart';
import '../widgets/recipe_tile_view.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({super.key});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    context.read<RecipeBloc>().add(LoadRandomRecipes(page: _currentPage));
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _currentPage++;
      context.read<RecipeBloc>().add(LoadRandomRecipes(page: _currentPage));
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Timer? _searchTimer;

  void _onSearchChanged(String query) {
    if (_searchTimer != null) {
      _searchTimer!.cancel();
    }
    _searchTimer = Timer(const Duration(milliseconds: 300), () {
      context.read<RecipeBloc>().add(SearchRecipes(query: query));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 1.5 * kToolbarHeight, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CustomDot(),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Recipes',
                    style: GoogleFonts.quicksand(
                      color: textBlackColor,
                      fontSize: 32,
                    ),
                  ),
                ),
                const SizedBox(width: 48),
              ],
            ),
            Row(
              children: const [
                Expanded(
                    child: Divider(
                  color: strokeBrownColor,
                )),
                SizedBox(width: 40),
                Spacer(),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              onChanged: _onSearchChanged,
              decoration: const InputDecoration(
                labelText: "Search Recipes",
                labelStyle: TextStyle(color: darkGreenColor),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: darkGreenColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: darkGreenColor),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SimpleText(
              "Here's a list of stuff you could prepare ",
              style: GoogleFonts.quicksand(
                color: textGreyColor,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: BlocBuilder<RecipeBloc, RecipeState>(
                builder: (context, state) {
                  if (state is RecipeLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is RecipeLoaded) {
                    if (state.recipes.isEmpty) {
                      return const Center(
                        child: Text("No recipes found"),
                      );
                    } else {
                      return ListView.builder(
                        controller: _scrollController,
                        itemCount: state.recipes.length,
                        itemBuilder: (context, index) {
                          final recipe = state.recipes[index];

                          return RecipeListTile(
                            recipe: recipe,
                          );
                        },
                      );
                    }
                  } else if (state is RecipeError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(state.message),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: state.onRetry,
                            child: const Text("Retry"),
                          ),
                        ],
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
