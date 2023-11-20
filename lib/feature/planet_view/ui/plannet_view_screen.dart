import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class ArPlanetViewScreen extends StatefulWidget {
  const ArPlanetViewScreen({super.key});

  @override
  ArPlanetViewScreenState createState() => ArPlanetViewScreenState();
}

class ArPlanetViewScreenState extends State<ArPlanetViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Model Viewer')),
      body: ModelViewer(
        onWebViewCreated: (controller){
          final a = controller.getScrollPosition();

          print(a);
          print('--------------------');
        },
        backgroundColor: Colors.white,
        src: 'https://modelviewer.dev/shared-assets/models/Astronaut.glb',
        alt: 'A 3D model of an astronaut',
        ar: true,
        autoRotate: true,
        iosSrc: 'https://modelviewer.dev/shared-assets/models/Astronaut.usdz',
        disableZoom: true,
      ),
    );
  }
}
