import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import '../../data/models/recipe.dart';
import '../../data/memory_repository.dart';

class MyRecipesList extends StatefulWidget {
  const MyRecipesList({Key? key}) : super(key: key);

  @override
  _MyRecipesListState createState() => _MyRecipesListState();
}

class _MyRecipesListState extends State<MyRecipesList> {
  List<Recipe> recipes = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: _buildRecipeList(context),
    );
  }

  Widget _buildRecipeList(BuildContext context) {
    // This creates a Consumer of a MemoryRepository, which receives the repository. That Consumer is a widget that can receive a class from a parent Provider.
    return Consumer<MemoryRepository>(
      builder: (context, repository, child) {
        // The method findAllRecipes() will return either all the current recipes or an empty list.
        recipes = repository.findAllRecipes();
        return ListView.builder(
            itemCount: recipes.length,
            itemBuilder: (BuildContext context, int index) {
              // itemBuilder receives the current index so that we can retrieve the recipe at that index.
              final recipe = recipes[index];
              return SizedBox(
                height: 100,
                child: Slidable(
                  actionPane: const SlidableDrawerActionPane(),
                  actionExtentRatio: 0.25,
                  child: Card(
                    elevation: 1.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.white,
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: CachedNetworkImage(
                              imageUrl: recipe.image ?? '',
                              height: 120,
                              width: 60,
                              fit: BoxFit.cover),
                          title: Text(recipe.label ?? ''),
                        ),
                      ),
                    ),
                  ),
                  actions: <Widget>[
                    IconSlideAction(
                        caption: 'Delete',
                        color: Colors.transparent,
                        foregroundColor: Colors.black,
                        iconWidget: const Icon(Icons.delete, color: Colors.red),
                        onTap: () => deleteRecipe(repository, recipe)),
                  ],
                  secondaryActions: <Widget>[
                    IconSlideAction(
                        caption: 'Delete',
                        color: Colors.transparent,
                        foregroundColor: Colors.black,
                        iconWidget: const Icon(Icons.delete, color: Colors.red),
                        onTap: () => deleteRecipe(repository, recipe)),
                  ],
                ),
              );
            });
      },
    );
  }

  void deleteRecipe(MemoryRepository repository, Recipe recipe) async {
    if (recipe.id != null) {
      // The repository to delete any recipe ingredients.
      repository.deleteRecipeIngredients(recipe.id!);
      // The repository to delete the recipe.
      repository.deleteRecipe(recipe);
      // setState() to redraw the view.
      setState(() {});
    } else {
      print('Recipe id is null');
    }
  }
}
