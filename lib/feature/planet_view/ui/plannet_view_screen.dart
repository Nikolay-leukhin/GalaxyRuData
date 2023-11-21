import 'dart:io';

import 'package:flutter/material.dart';
import 'package:galaxy_rudata/utils/utils.dart';
import 'package:galaxy_rudata/widgets/app_bars/main_app_bar.dart';
import 'package:galaxy_rudata/widgets/buttons/custom_button.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class ArPlanetViewScreen extends StatefulWidget {
  const ArPlanetViewScreen({super.key});

  @override
  ArPlanetViewScreenState createState() => ArPlanetViewScreenState();
}

class ArPlanetViewScreenState extends State<ArPlanetViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/galaxy.jpg"))),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: MainAppBar.logoutWallet(context),
          body: Stack(
            children: [
              Center(
                child: ModelViewer(
                  touchAction: TouchAction.none,
                  onWebViewCreated: (controller) {
                    final a = controller.getScrollPosition();
                    print(a);
                    print('--------------------');
                  },
                  disableTap: true,
                  backgroundColor: Colors.transparent,
                  src: 'assets/planet.glb',
                  alt: 'A 3D model of an astronaut',
                  ar: false,
                  autoRotate: true,
                  iosSrc: 'assets/planet.glb',
                  disableZoom: true,
                  disablePan: true,
                ),
              ),
              Center(
                child: Opacity(
                    opacity: 0,
                    child: CustomButton(
                        content: Text('shit'),
                        onTap: () => showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (context) => Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24),
                                  color: Colors.red,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: List.generate(
                                        10,
                                        (index) => Container(
                                          margin: EdgeInsets.all(10),
                                              height: 20,
                                              width: 20,
                                              color: Colors.black,
                                            )),
                                  )),
                            ),
                        width: 100)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ClusterWidget extends StatelessWidget {
  final String name;

  const ClusterWidget({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.darkBlue3,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            name,
            style: AppTypography.font16w600.copyWith(color: Colors.white),
          ),
          InkWell(
            onTap: () {},
            child: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
              size: 24,
            ),
          )
        ],
      ),
    );
  }
}
