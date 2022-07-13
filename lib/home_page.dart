import 'package:ar_demo/model.dart';
import 'package:ar_demo/object_gestures.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final List<ARModel> arModels = [
    ARModel(
        uri: "images/cheeseburger_bao_buns/scene.gltf", name: 'CHEESE BURGER'),
    ARModel(
      uri: "images/pumpkin/scene.gltf",
      name: 'PUMPKIN',
    ),
    ARModel(
      uri: "images/pizza/pizza.gltf",
      name: 'PIZZA',
    ),
    ARModel(
      uri: "images/doughnut/scene.gltf",
      name: 'DOUGHNUT',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Model'),
      ),
      body: ListView.separated(
        itemBuilder: (_, index) => ListTile(
          title: Text(arModels[index].name),
          trailing: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
            ),
            child: Text('View in 3D'),
          ),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ObjectGesturesWidget(uri: arModels[index].uri),
            ),
          ),
        ),
        separatorBuilder: (_, __) => const Divider(),
        itemCount: arModels.length,
      ),
    );
  }
}
