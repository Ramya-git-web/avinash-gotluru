import 'package:ar_demo/model/recipe_model.dart';
import 'package:ar_demo/utils/app.dart';
import 'package:ar_demo/views/view_ar_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}
// uri: "images/pumpkin/scene.gltf",
// uri: "images/pizza/pizza.gltf",
// uri: "images/doughnut/scene.gltf",
class _HomePageState extends State<HomePage> {
  List<RecipeModel> recipe = [
    RecipeModel(
        title: 'Pizza Quattro Stagioni',
        asset: 'images/pizza.png',
        uri: 'images/pizza/pizza.gltf',
        description: 'Artichokes, tomatoes, basil, mushrooms & ham'),
    RecipeModel(
        title: 'Doughnut',
        asset: 'images/doughnut.png',
        uri: 'images/doughnut/scene.gltf',
        description: 'Rise, onion, mushrooms, parmigiano & oregano'),
    RecipeModel(
        title: 'Cheese burger',
        asset: 'images/cheese.png',
        uri: 'images/cheeseburger_bao_buns/scene.gltf',
        description: 'Tomatoes, home toasted bread, guacamole & cream cheese'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
                3,
                (index) => itemCard(
                    asset: recipe[index].asset,
                    title: recipe[index].title,
                    uri: recipe[index].uri,
                    description: recipe[index].description))),
      ),
    );
  }

  itemCard({String? asset, String? title, String? description, String? uri}) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Image.asset(asset!),
          App.columnSpacer(),
          Text(title!,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          App.columnSpacer(),
          Text(description!,
              style:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.normal)),
          App.columnSpacer(),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              minimumSize: Size(App.width, App.height * 0.08),
            ),
            onPressed: () {
              App.push(ViewAr(uri: uri!));
            },
            child: Text('View in 3D',
                style: TextStyle(color: Colors.deepPurple[900])),
          ),
        ],
      ),
    );
  }
}
