import 'package:ar_demo/model/recipe_model.dart';
import 'package:ar_demo/object_gestures.dart';
import 'package:ar_demo/utils/app.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<RecipeModel> recipe = [
    RecipeModel(
      title: 'Pumpkin',
      asset: 'images/ic_pumpkin.png',
      uri: 'images/pumpkin/scene.gltf',
      description: 'Pumpkin is a sweet, orange, and meaty vegetable.',
    ),RecipeModel(
      title: 'Pizza Quattro Stagioni',
      asset: 'images/pizza.png',
      uri: 'images/pizza/pizza.gltf',
      description: 'Artichokes, tomatoes, basil, mushrooms & ham',
    ),
    RecipeModel(
      title: 'Doughnut',
      asset: 'images/doughnut.png',
      uri: 'images/doughnut/scene.gltf',
      description: 'Rise, onion, mushrooms, parmigiano & oregano',
    ),
    RecipeModel(
      title: 'Cheese burger',
      asset: 'images/cheese.png',
      uri: 'images/cheeseburger_bao_buns/scene.gltf',
      description: 'Tomatoes, home toasted bread, guacamole & cream cheese',
    ),
    RecipeModel(
      title: 'Ice Cream',
      asset: 'images/ic_icecream.png',
      uri: 'images/ice_cream/scene.gltf',
      description: 'Bunch of ice cream with a twist of chocolate and variety of flavours',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AR Demo'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: recipe.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (_, index) => itemCard(
          recipe[index],
        ),
      ),
    );
  }

  itemCard(RecipeModel model) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: Image.asset(
              model.asset ?? '',
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          App.columnSpacer(height: 10),
          Text(
            model.title ?? '',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          App.columnSpacer(height: 5),
          Text(
            model.description ?? '',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.normal,
            ),
          ),
          App.columnSpacer(height: 10),
          OutlinedButton.icon(
            icon: Icon(
              Icons.zoom_out_map,
              color: Colors.deepPurple[900],
            ),
            onPressed: () {
              if (model.uri != null) {
                App.push(
                  ObjectGesturesWidget(
                    uri: model.uri!,
                    name: model.title ?? '',
                  ),
                );
              }
            },
            label: Text(
              'View in 3D',
              style: TextStyle(
                color: Colors.deepPurple[900],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
