import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/models/ar_anchor.dart';
import 'package:flutter/material.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/datatypes/hittest_result_types.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:ar_flutter_plugin/models/ar_hittest_result.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ObjectGesturesWidget extends StatefulWidget {
  const ObjectGesturesWidget({Key? key, required this.uri, required this.name})
      : super(key: key);

  final String uri;
  final String name;

  @override
  State<ObjectGesturesWidget> createState() => _ObjectGesturesWidgetState();
}

class _ObjectGesturesWidgetState extends State<ObjectGesturesWidget> {
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  ARAnchorManager? arAnchorManager;

  List<ARNode> nodes = [];
  List<ARAnchor> anchors = [];

  int _value = 10;
  int _rotationXValue = 0;
  int _rotationYValue = 0;
  int _rotationZValue = 0;
  bool showSlider = false;
  bool showRotationSlider = false;

  @override
  void dispose() {
    super.dispose();
    arSessionManager!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Column(
        children: [
          Expanded(
            child: ARView(
              onARViewCreated: onARViewCreated,
              planeDetectionConfig: PlaneDetectionConfig.horizontal,
            ),
          ),
          if (showSlider)
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 1,
                ),
                color: Colors.black38,
              ),
              child: Slider(
                value: _value.toDouble(),
                min: 1.0,
                max: 100.0,
                divisions: 50,
                activeColor: Colors.green,
                inactiveColor: Colors.orange,
                label: 'Set scaling',
                onChanged: (double newValue) {
                  setState(() {
                    _value = newValue.round();
                  });
                  for (var value in nodes) {
                    final newTransform = Matrix4.identity();
                    newTransform.scale(newValue);
                    value.transform = newTransform;
                  }
                },
              ),
            ),
          if (showRotationSlider)
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 1,
                ),
                color: Colors.black38,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const Text('X-axis'),
                        Slider(
                          value: _rotationXValue.toDouble(),
                          min: 0.0,
                          max: 360.0,
                          divisions: 30,
                          activeColor: Colors.green,
                          inactiveColor: Colors.orange,
                          label: 'Set X rotation',
                          onChanged: (double newValue) {
                            setState(() {
                              _rotationXValue = newValue.round();
                            });
                            for (var value in nodes) {
                              value.rotation = vector.Matrix3.rotationX(newValue);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        const Text('Y-axis'),
                        Slider(
                          value: _rotationYValue.toDouble(),
                          min: 0.0,
                          max: 360.0,
                          divisions: 30,
                          activeColor: Colors.green,
                          inactiveColor: Colors.orange,
                          label: 'Set Y rotation',
                          onChanged: (double newValue) {
                            setState(() {
                              _rotationYValue = newValue.round();
                            });
                            for (var value in nodes) {
                              value.rotation = vector.Matrix3.rotationY(newValue);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        const Text('Z-axis'),
                        Slider(
                          value: _rotationZValue.toDouble(),
                          min: 0.0,
                          max: 360.0,
                          divisions: 30,
                          activeColor: Colors.green,
                          inactiveColor: Colors.orange,
                          label: 'Set Z rotation',
                          onChanged: (double newValue) {
                            setState(() {
                              _rotationZValue = newValue.round();
                            });
                            for (var value in nodes) {
                              value.rotation = vector.Matrix3.rotationZ(newValue);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    showRotationSlider = false;
                    showSlider = !showSlider;
                  });
                },
                icon: const Icon(
                  Icons.aspect_ratio,
                  color: Colors.redAccent,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    showSlider = false;
                    showRotationSlider = !showRotationSlider;
                  });
                },
                icon: const Icon(
                  Icons.threed_rotation_outlined,
                  color: Colors.redAccent,
                ),
              ),
              IconButton(
                onPressed: onRemoveEverything,
                icon: const Icon(
                  Icons.highlight_remove,
                  color: Colors.redAccent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void onARViewCreated(
      ARSessionManager arSessionManager,
      ARObjectManager arObjectManager,
      ARAnchorManager arAnchorManager,
      ARLocationManager arLocationManager) {
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;
    this.arAnchorManager = arAnchorManager;

    this.arSessionManager!.onInitialize(
          showFeaturePoints: false,
          showPlanes: false,
          showWorldOrigin: false,
          handlePans: true,
          handleRotation: true,
        );
    this.arObjectManager!.onInitialize();

    this.arSessionManager!.onPlaneOrPointTap = onPlaneOrPointTapped;
    this.arObjectManager!.onPanStart = onPanStarted;
    this.arObjectManager!.onPanChange = onPanChanged;
    this.arObjectManager!.onPanEnd = onPanEnded;
    this.arObjectManager!.onRotationStart = onRotationStarted;
    this.arObjectManager!.onRotationChange = onRotationChanged;
    this.arObjectManager!.onRotationEnd = onRotationEnded;
  }

  Future<void> onRemoveEverything() async {
    for (var anchor in anchors) {
      arAnchorManager!.removeAnchor(anchor);
    }
    anchors = [];
  }

  Future<void> onPlaneOrPointTapped(
      List<ARHitTestResult> hitTestResults) async {
    var singleHitTestResult = hitTestResults.firstWhere(
        (hitTestResult) => hitTestResult.type == ARHitTestResultType.plane);
    var newAnchor =
        ARPlaneAnchor(transformation: singleHitTestResult.worldTransform);
    bool? didAddAnchor = await arAnchorManager!.addAnchor(newAnchor);
    if (didAddAnchor == true) {
      anchors.add(newAnchor);

      var newNode = ARNode(
        type: NodeType.localGLTF2,
        uri: widget.uri,
        scale: vector.Vector3.all(_value.toDouble()),
        position: vector.Vector3(0.0, 0.0, 0.0),
        rotation: vector.Vector4(1.0, 0.0, 0.0, 0.0),
      );
      bool? didAddNodeToAnchor =
          await arObjectManager!.addNode(newNode, planeAnchor: newAnchor);
      if (didAddNodeToAnchor == true) {
        nodes.add(newNode);
      } else {
        arSessionManager!.onError("Adding Node to Anchor failed");
      }
    } else {
      arSessionManager!.onError("Adding Anchor failed");
    }
  }

  onPanStarted(String nodeName) {
    debugPrint("Started panning node $nodeName");
  }

  onPanChanged(String nodeName) {
    debugPrint("Continued panning node $nodeName");
  }

  onPanEnded(String nodeName, Matrix4 newTransform) {
    debugPrint("Ended panning node $nodeName");
    // final pannedNode = nodes.firstWhere((element) => element.name == nodeName);
    // pannedNode.transform = newTransform;
  }

  onRotationStarted(String nodeName) {
    debugPrint("Started rotating node $nodeName");
  }

  onRotationChanged(String nodeName) {
    debugPrint("Continued rotating node $nodeName");
  }

  onRotationEnded(String nodeName, Matrix4 newTransform) {
    debugPrint("Ended rotating node $nodeName");
    // final rotatedNode = nodes.firstWhere((element) => element.name == nodeName);
    // rotatedNode.transform = newTransform;
  }
}
