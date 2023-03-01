import 'package:flutter/material.dart';

import '../data/dummy_data.dart';

class MealDetailScreenArguments {
  final String id;

  MealDetailScreenArguments(this.id);
}

Widget _buildSectionTitle(BuildContext ctx, String text) {
  return Container(
    margin: const EdgeInsets.symmetric(
      vertical: 10,
    ),
    child: Text(
      text,
      style: Theme.of(ctx).textTheme.headline6,
    ),
  );
}

Widget _buildListContainer(Widget child, double height, double width) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(
        color: Colors.grey,
      ),
      borderRadius: BorderRadius.circular(10.0),
    ),
    margin: const EdgeInsets.all(10.0),
    padding: const EdgeInsets.all(10.0),
    height: height,
    width: width,
    child: child,
  );
}

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';

  final Function toggleFavorite;
  final Function isFavorite;

  MealDetailScreen(this.toggleFavorite, this.isFavorite);

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as MealDetailScreenArguments;

    final selectedMeal =
        DUMMY_MEALS.firstWhere((element) => element.id == routeArgs.id);

    final MediaQueryData mediaQuery = MediaQuery.of(context);

    final double listContainerHeight = mediaQuery.size.height * 0.3;
    final double listContainerWidth = mediaQuery.size.height * 0.35;

    return Scaffold(
      appBar: AppBar(
        title: Text('${selectedMeal.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10.0),
              height: mediaQuery.size.height * 0.35,
              width: double.infinity,
              child: Image.network(
                '${selectedMeal.imageURL}',
                fit: BoxFit.cover,
              ),
            ),
            _buildSectionTitle(context, 'Ingredients'),
            _buildListContainer(
              ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    color: Theme.of(context).accentColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5.0,
                        horizontal: 10.0,
                      ),
                      child: Text(
                        selectedMeal.ingredients[index],
                      ),
                    ),
                  );
                },
                itemCount: selectedMeal.ingredients.length,
              ),
              listContainerHeight,
              listContainerWidth,
            ),
            _buildSectionTitle(context, 'Steps'),
            _buildListContainer(
              ListView.builder(
                itemBuilder: (ctx, index) => Column(
                  children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('# ${index + 1}'),
                      ),
                      title: Text(
                        selectedMeal.steps[index],
                      ),
                    ),
                    Divider(),
                  ],
                ),
                itemCount: selectedMeal.steps.length,
              ),
              listContainerHeight,
              listContainerWidth,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => toggleFavorite(routeArgs.id),
        child: Icon(
          isFavorite(routeArgs.id) ? Icons.star : Icons.star_border,
        ),
      ),
    );
  }
}
