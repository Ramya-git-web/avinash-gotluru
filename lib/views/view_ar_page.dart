import 'package:ar_demo/object_gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';

class ViewAr extends StatefulWidget {
  const ViewAr({Key? key, required this.uri}) : super(key: key);

  final String uri;
  @override
  State<ViewAr> createState() => _ViewArState();
}

class _ViewArState extends State<ViewAr> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await ArFlutterPlugin.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text('Running on: $_platformVersion\n'),
            Expanded(
              child: ObjectGesturesWidget(uri: widget.uri),
            ),
          ],
        ),
      ),
    );
  }
}
